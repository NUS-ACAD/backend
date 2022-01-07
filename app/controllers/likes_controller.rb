class LikesController < ApplicationController
    def index
        likes = Like.all
        render json: likes
    end

    def create
        liker_id = @user[:id]
        plan_id = likes_params[:plan_id]
        to_like = likes_params[:to_like]
        if to_like == "true"
            @like = Like.create(plan_id: plan_id, user_id: liker_id)
            render json: @like
        else
            @like = Like.find_by(plan_id: plan_id, user_id: liker_id)
            @like.destroy
            render json: @like
        end
    end 

    private
    def likes_params
        params.permit(:to_like, :plan_id)
    end
end
