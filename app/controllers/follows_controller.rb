class FollowsController < ApplicationController
    def index
        follows = Follow.all
        render json: follows
    end

    def create
        followed_id = follow_params[:user_id]
        to_follow = follow_params[:to_follow]
        puts to_follow.inspect
        follower_id = @user[:id]
        if to_follow == "true"
            @follow = Follow.create(follower_id: follower_id, followed_id: followed_id)
            render json: @follow
        else
            @follow = Follow.find_by(follower_id: follower_id, followed_id: followed_id)
            @follow.destroy
            render json: @follow
        end
    end

    def follow_params
        params.permit(:to_follow, :user_id)
    end
end
