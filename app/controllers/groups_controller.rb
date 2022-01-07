class GroupsController < ApplicationController
    def index
        groups = Group.all
        render json: groups
    end

    def create
        group = Group.create(:name => group_create_param[:name], :description => group_create_param[:description])
        member = Members.create(:name => @user.id, :group => group.id, :is_owner => true)
        json_response({member: member, group: group}, :created)
    end

    def group_create_params
        # whitelist params #properties tied directly to params, not within an object
        params.permit(:name, :description, :created_at, :updated_at)
      end
end
