class GroupsController < ApplicationController

    # GET /groups
    def index
        groups = Group.all
        render json: groups
    end

    # GET /groups/:id - gets name, desc (optional), all members in group
    def show
        @group = Group.find(params[:id])
        members = Member.where(group_id: params[:id])
        render json: { group_data: @group, members: members }
    end

    # POST /groups
    def create
        group = Group.create!(group_create_params)
        member = Member.create!(user_id: @user[:id], group_id: group[:id], is_owner: true)
        # json_response({member: member, group: group}, :created)
        Feed.create!(user_id: @user.id, user_name: @user.name, activity_type: Feed::ACTIVITY_TYPES[:created_group], group_id: group.id, group_name: group.name)

        render json: {message: "created"}
    end

    # DELETE /groups/:id
    def destroy
        member = Member.find_by(user_id: @user[:id], group_id: params[:id])
        if member[:is_owner]
            deleted = Group.find_by(id: params[:id]).destroy
            Feed.create!(user_id: @user.id, user_name: @user.name, activity_type: Feed::ACTIVITY_TYPES[:deleted_group],group_id: params[:id], group_name: deleted.name)
            render json: {message: "deleted"}
        else
            render json: {message: "Non-owner cannot delete"}
        end
    end

    # PATCH /groups/:id
    def update
        member = Member.find_by(user_id: @user[:id], group_id: params[:id])
        if member[:is_owner]
            if !group_update_params[:add_owner_member_id].nil?
                group_id = params[:id]
                # check if user made as owner is member of the group
                member = Member.find_by(user_id: group_update_params[:add_owner_member_id], group_id: group_id)
                if member.nil?
                    render json: { message: "owner must be member of the group" }
                else
                    Member.delete_by(user_id: group_update_params[:add_owner_member_id], group_id: group_id)
                    Member.create(user_id: group_update_params[:add_owner_member_id], group_id: group_id, is_owner: true)
                end
            elsif !group_update_params[:remove_owner_member_id].nil?
                group_id = params[:id]
                # check if user made as owner is member of the group
                member = Member.find_by(user_id: group_update_params[:add_owner_member_id], group_id: group_id)
                if member.nil?
                    render json: { message: "user must be owner of the group" }
                elsif !member[:is_owner]
                    render json: { message: "user must be owner of the group" }
                else
                    Member.delete_by(user_id: group_update_params[:remove_owner_member_id], group_id: group_id)
                    Member.create(user_id: group_update_params[:remove_owner_member_id], group_id: group_id, is_owner: false)
                end
            elsif !group_update_params[:delete_member_id].nil?
                group_id = params[:id]
                Member.delete_by(user_id: group_update_params[:delete_member_id], group_id: group_id) 
            end

            Feed.create!(user_id: @user.id, user_name: @user.name, activity_type: Feed::ACTIVITY_TYPES[:changed_group], group_id: params[:id], group_name: Group.find(params[:id]).name)
        else
            render json: {message: "Non-owner cannot update"}
        end
    end

    # POST /groups/:id/leave
    # must be in the group and can't be the only owner
    def leave
        @member = Member.find_by(user_id: @user[:id], group_id: params[:id])
        @group_owners = Member.where(is_owner: true, group_id: params[:id])
        if @member.nil? 
            render json: {message: "user is not member of the group"}
        else
            if @group_owners.length() == 1
                if @member[:is_owner]
                    render json: {message: "User is owner of group and cannot leave"}
                else
                    @member.destroy
                    json_response({message: "User no longer member of group"})
                end
            else
                @member.destroy
                json_response({message: "User no longer member of group"})
            end
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
