class PlansController < ApplicationController
    before_action :set_plan, only: [:show, :update, :destroy, :fork]
    before_action :check_authorised, only: [:destroy, :update] 

    # POST /plans
    def create
        create_plan = clean_nested_plan(plan_params)
        create_plan[:owner_id] = @user.id
        @plan = Plan.create!(create_plan)
        validate_is_primary
        
        Feed.create!(user_id: @user.id, user_name: @user.name, activity_type: Feed::ACTIVITY_TYPES[:created_plan], plan_name:@plan.title, plan_id: @plan.id)
        # json_response(create_plan, :created)

        json_response(generate_full_plan(@plan), :created)
    end

    # PUT /plans/:id
    def update
        raw = @plan.to_json
        @plan.semesters.destroy_all
        plan_params[:owner_id] = @user.id
        @plan.update!(clean_nested_plan(plan_params))
        validate_is_primary
        Feed.create!(user_id: @user.id, user_name: @user.name, activity_type: Feed::ACTIVITY_TYPES[:updated_plan], plan_name:@plan.title, plan_id: @plan.id)

        json_response(generate_full_plan(@plan), :created)
    end

    # DELETE /plans/:id
    def destroy
        destroyed = @plan.destroy!
        if destroyed.is_primary && @user.plans.length != 0
            @user.plans.first.update!(is_primary: true)
        end
        Feed.create!(user_id: @user.id, user_name: @user.name, activity_type: Feed::ACTIVITY_TYPES[:deleted_plan], plan_name: destroyed.title, plan_id: destroyed.id)

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
            sem[:modules] = sem[:modules].map do |mod|
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

        Feed.create!(user_id: @user.id, user_name: @user.name, activity_type: Feed::ACTIVITY_TYPES[:forked_plan], plan_name:@plan.title, plan_id: @plan.id, second_plan_id: @forked_plan.id, second_plan_name: @forked_plan.title)

        json_response(generate_full_plan(@forked_plan), :created)
    end


    private

    def clean_nested_plan(plan)
        plan[:semesters_attributes] = plan[:semesters]
        plan = plan.except(:semesters)
        plan[:semesters_attributes] = plan[:semesters_attributes].map do |sem|
            sem[:mods_attributes] = sem[:modules]
            sem.except(:modules)
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
                    { modules: [
                        :module_code, :module_title, :additional_desc, :order]}]})
    end

    def validate_is_primary
        before = @user.plans.find_by(is_primary: true)
        if @plan.is_primary
            @user.plans.where.not(id: @plan.id).update_all(is_primary: false)
        elsif @user.plans.where(is_primary: true).length == 0
            @plan.update!(is_primary: true)
        end
        after = @user.reload.plans.find_by(is_primary: true)
        if before && after && before.id != after.id
            Feed.create!(user_id: @user.id, user_name: @user.name, activity_type: Feed::ACTIVITY_TYPES[:changed_primary_plan], plan_name: after.title, plan_id: after.id)
        end
    end

    def generate_full_plan(plan)
        just_plan = Plan.find(plan.id).attributes.transform_keys(&:to_sym)
        just_plan[:semesters] = Plan.find(plan.id).semesters.map do |sem|
            sem_json = sem.attributes.transform_keys(&:to_sym)
            sem_json[:modules] = sem.mods.as_json.map{ |mod| mod.transform_keys(&:to_sym) }
            sem_json
        end
        just_plan
    end

end



