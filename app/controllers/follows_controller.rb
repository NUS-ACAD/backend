class FollowsController < ApplicationController
    def index
        follows = Follow.all
        render json: follows
    end

    def create
        followed_id = follow_params[:user_id]
        to_follow = follow_params[:to_follow]
        follower_id = @user[:id]
        if to_follow == "true"
            @follow = Follow.create(follower_id: follower_id, followed_id: followed_id)
            render json: @follow
        else
            # check if there exists a follow to delete
            @follow = Follow.find_by(follower_id: follower_id, followed_id: followed_id)
            if @follow.nil?
               json_response({ message: "unfollowing not possible as user was not following" }) 
            else
                @follow.destroy
                json_response({ message: "user has been unfollowed" })
            end
        end
    end

    private
    def follow_params
        params.permit(:to_follow, :user_id)
    end
end
