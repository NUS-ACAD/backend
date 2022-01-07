class PlansController < ApplicationController
    before_action :set_plan, only: [:show, :update, :destroy]
    before_action :check_authorised, only: [:destroy, :update] 

    # GET /plans
    def index
        json_response(@user.plans)
    end
    
    private

    def set_plan
        @plan = Plan.find(params[:id])
    end

    def create:
        @todo = todo_params
        puts @todo.inspect

    def check_authorised
        json_response({ message: "Unauthorised."}, :unauthorized) if @user.id != @plan.user_id
    end
end
