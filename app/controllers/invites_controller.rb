class InvitesController < ApplicationController
    # GET /invites
    def index
        invites = Invite.all
        render json: invites
    end

    # GET /invites/:id
    def get_invites_for_user
        @invites = Invite.where(invitee_id: params[:id])
        render json: @invites
    end

    # POST /invites
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

    # DELETE /invites/:id
    def destroy
        # check if request sent by owner of group
        @invite = Invite.find(params[:id])
        invite_group_id = @invite[:group_id]
        group_owner_id = Member.find_by(group_id: invite_group_id, is_owner: true)[:user_id]
        req_user_id = @user[:id]
        if @invite[:status] != "PENDING"
            json_response({message: "Invite status is not pending and cannot be deleted"})
        elsif group_owner_id != req_user_id
            json_response({message: "User not owner of group and cannot delete invite"}, :unprocessable_entity)
        else
            @invite.destroy
            json_response({message: "Invite deleted"})
        end
    end

    # PATCH /invites/:id
    def update
        invite_update = invite_params
        new_status = invite_update[:new_status]
        @invite = Invite.find(params[:id])
        invitee_id = @invite[:invitee_id]
        if @invite[:status] != "PENDING"
            json_response({message: "Invite status is not pending and cannot change"})
        elsif invitee_id != params[:id]
            json_response({message: "User is not the invitee and cannot change status"})
        else
            @invite.update(status: new_status)
            json_response({message: "Invite has been updated"})
        end
        
    end
    private

    def invite_params
        params.permit(:invitee_id, :group_id, :new_status)
    end
end