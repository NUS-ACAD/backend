class InvitesController < ApplicationController
    def index
        invites = Invite.all
        render json: invites
    end
end
