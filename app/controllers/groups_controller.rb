class GroupsController < ApplicationController
    def index
        groups = Group.all
        render json: groups
    end

    def create
        group = Group.create(group_create_params)
        member = Member.create(user_id: @user[:id], group_id: group[:id], is_owner: true)
        # json_response({member: member, group: group}, :created)
        render json: {message: "created"}
    end

    def destroy
        member = Member.find_by(user_id: @user[:id], group_id: group_delete_params[:group_id])
        if member[:is_owner]
            Group.find_by(id: group_delete_params[:group_id]).destroy
            render json: {message: "deleted"}
        else
            render json: {message: "Non-owner cannot delete"}
        end
    end

    def update
        member = Member.find_by(user_id: @user[:id], group_id: group_update_params[:group_id])
        if member[:is_owner]
            if !group_update_params[:add_owner_member_id].nil?
                group_id = group_update_params[:group_id]
                Member.delete_by(user_id: group_update_params[:add_owner_member_id], group_id: group_id)
                Member.create(user_id: group_update_params[:add_owner_member_id], group_id: group_id, is_owner: true)
            elsif !group_update_params[:remove_owner_member_id].nil?
                group_id = group_update_params[:group_id]
                Member.delete_by(user_id: group_update_params[:remove_owner_member_id], group_id: group_id)
                Member.create(user_id: group_update_params[:remove_owner_member_id], group_id: group_id, is_owner: false)
            elsif !group_update_params[:delete_member_id].nil?
                group_id = group_update_params[:group_id]
                Member.delete_by(user_id: group_update_params[:delete_member_id], group_id: group_id) 
            end
            render json: {message: "group updated"}
        else
            render json: {message: "Non-owner cannot update"}
        end
    end

    private

    def group_create_params
        # whitelist params #properties tied directly to params, not within an object
        params.permit(:name, :description)
    end

    def group_update_params
        params.permit(:group_id, :delete_member_id, :add_owner_member_id, :remove_owner_member_id)
    end

    def group_delete_params
        params.permit(:group_id, :delete_member_id, :add_owner_member_id, :remove_owner_member_id)
    end
end
