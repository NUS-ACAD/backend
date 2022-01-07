class PlansController < ApplicationController
    before_action :set_plan, only: [:show, :update, :destroy, :fork]
    before_action :check_authorised, only: [:destroy, :update] 

    # POST /plans
    def create
        create_plan = clean_nested_plan(plan_params)
        create_plan[:owner_id] = @user.id
        @plan = Plan.create!(create_plan)
        validate_is_primary
        
        json_response(generate_full_plan(@plan), :created)
    end

    # PUT /plans/:id
    def update
        @plan.semesters.destroy_all
        plan_params[:owner_id] = @user.id
        @plan.update!(clean_nested_plan(plan_params))
        validate_is_primary
        json_response(generate_full_plan(@plan), :created)
    end

    # DELETE /plans/:id
    def destroy
        destroyed = @plan.destroy!
        if destroyed.is_primary && @user.plans.length != 0
            @user.plans.first.update!(is_primary: true)
        end
        head :no_content
    end

    # GET /plans/:id
    def show
        json_response(generate_full_plan(Plan.find(params[:id])))
    end

    def fork
        # Let source’s matriculation year be x and copier’s matriculation year be y
        # Maps through all source’s semesters, sets year i to be i+(y-x)
        # Sets owner_id to be copier’s
        # Set forked_plan_source_id to be source
        # Is_primary is default to be false unless first.
        # Forks that plan and creates a new plan for user
        # Returns the new plan_id (for redirection purposes)
        source = generate_full_plan(@plan)
        forked = generate_full_plan(@plan)
        diff = @plan.user.matriculation_year - @user.matriculation_year
        forked[:semesters] = forked[:semesters].map do |sem|
            sem[:year] -= diff
            sem[:mods] = sem[:mods].map do |mod|
                mod = mod.except(:id)
                mod.except(:semester_id)
            end
            sem = sem.except(:id)
            sem.except(:plan_id)
        end


        forked[:owner_id] = @user.id
        forked[:forked_plan_source_id] = @plan.id
        forked[:start_year] = @user.matriculation_year
        

        @forked_plan = Plan.create!(clean_nested_plan(forked).except(:id))
        json_response(generate_full_plan(@forked_plan), :created)
    end


    private

    def clean_nested_plan(plan)
        plan[:semesters_attributes] = plan[:semesters]
        plan = plan.except(:semesters)
        plan[:semesters_attributes] = plan[:semesters_attributes].map do |sem|
            sem[:mods_attributes] = sem[:mods]
            sem.except(:mods)
        end
        plan
    end
  
    def set_plan
        @plan = Plan.find(params[:id])
    end

    def check_authorised
        json_response({ message: "Unauthorised."}, :unauthorized) if @user.id != @plan.owner_id
    end

    def plan_params
        params.permit(:is_primary, :start_year, :title, :description, 
            { semesters: [
                :year, :semester_no,
                    { mods: [
                        :module_code, :module_title, :additional_desc, :order]}]})
    end

    def validate_is_primary
        if @plan.is_primary
            @user.plans.where.not(id: @plan.id).update_all(is_primary: false)
        elsif @user.plans.where(is_primary: true).length == 0
            @plan.update!(is_primary: true)
        end
    end

    def generate_full_plan(plan)
        just_plan = Plan.find(plan.id).attributes.transform_keys(&:to_sym)
        just_plan[:semesters] = Plan.find(plan.id).semesters.map do |sem|
            sem_json = sem.attributes.transform_keys(&:to_sym)
            sem_json[:mods] = sem.mods.as_json.map{ |mod| mod.transform_keys(&:to_sym) }
            sem_json
        end
        just_plan
    end
end



