class InvitesController < ApplicationController
    # GET /invite
    def index
        invites = Invite.all
        render json: invites
    end

    # POST /invite
    def create
        # check if request sent by owner of group
        invite_group_id = invite_params[:group_id]
        group_owner_id = Member.find_by(group_id: invite_group_id, is_owner: true)[:user_id]
        req_user_id = @user[:id]    
        if group_owner_id != req_user_id
            json_response({message: "User not owner of group and cannot send invite"}, :unprocessable_entity)
        else
            invite_create = invite_params
            @invite = Invite.create(invitee_id: invite_params[:invitee_id], group_id: invite_params[:group_id], status: "PENDING")
            render json: @invite
        end
    end

    # DELETE /invite/:id
    def destroy
        # check if request sent by owner of group
        @invite = Invite.find(params[:id])
        invite_group_id = @invite[:group_id]
        group_owner_id = Member.find_by(group_id: invite_group_id, is_owner: true)[:user_id]
        req_user_id = @user[:id]
        if group_owner_id != req_user_id
            json_response({message: "User not owner of group and cannot delete invite"}, :unprocessable_entity)
        else
            @invite.destroy
            json_response({message: "Invite deleted"})
        end
    end

    # PATCH /invite/:id
    def update
        invite_update = invite_params
        new_status = invite_update[:new_status]
        @invite = Invite.find(params[:id])
        @invite.update(status: new_status)
        render json: @invite
        
    end
    private

    def invite_params
        params.permit(:invitee_id, :group_id, :new_status)
    end
end