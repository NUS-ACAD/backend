class PlansController < ApplicationController
    before_action :set_plan, only: [:show, :update, :destroy]
    before_action :check_authorised, only: [:destroy, :update] 

    # GET /plans
    def index
        json_response(@user.plans)
    end

    # POST /plans
    def create
        @plan = Plan.create!(clean_nested_plan(plan_params))
        json_response(generate_full_plan(@plan), :created)
    end

    # PUT /plans/:id
    def update
        @plan.semesters.destroy_all
        @plan.update!(clean_nested_plan(plan_params))
        json_response(generate_full_plan(@plan), :created)
    end

    # DELETE /plans/:id
    def destroy
        @plan.destroy!
        head :no_content
    end

    # GET /plans/:id
    def show
        json_response(Plan.find(params[:id]))
    end

    private

    def clean_nested_plan(plan)
        plan[:owner_id] = @user.id
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

    def create:
        @todo = todo_params
        puts @todo.inspect

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

    def generate_full_plan(plan)
        just_plan = Plan.find(plan.id).as_json
        just_plan[:semesters] = Plan.find(plan.id).semesters.map do |sem|
            sem_json = sem.as_json
            sem_json[:mods] = sem.mods
            sem_json
        end
        just_plan
    end
end



