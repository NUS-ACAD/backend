class PlansController < ApplicationController
<<<<<<< HEAD
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

    def check_authorised
        json_response({ message: "Unauthorised."}, :unauthorized) if @user.id != @plan.user_id
=======
    def index
        plans = Plan.all
        render json: plans
>>>>>>> 3f29ab899cb856f4c19ac7d548b86f68d0d238a1
    end
end
