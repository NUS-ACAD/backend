class GroupsController < ApplicationController
    def index
        groups = Group.all
        render json: groups
    end

    def leave
        puts params[:id].inspect
    end

end
