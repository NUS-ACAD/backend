class UsersController < ApplicationController
    before_action :authorized, only: [:auto_login, :index]

    # REGISTER
    def create
        @user = User.create!(user_params)
        token = encode_token({user_id: @user.id})
        render json: {user: @user, token: token}
    end

    # LOGGING IN
    def login
        @user = User.find_by(email: params[:email])

        if @user && @user.authenticate(params[:password])
            token = encode_token({user_id: @user.id})
            render json: {user: @user, token: token}
        else
            json_response({ message: "Invalid email or password" }, :unprocessable_entity)
        end
    end

    def auto_login
        render json: @user
    end

    # GET users/:id
    def index
        # user data
        @user_data = User.find_by(id: params[:id])

        if @user_data.nil?
            json_response({message: "user does not exist"})
        else

            no_of_followers = 0
            no_of_following = 0
            is_user_following = false
            Follow.find_each do |follow|
                if follow[:follower_id] == @user[:id] && follow[:followed_id] == params[:id].to_i
                    is_user_following = true
                end

                if follow[:follower_id] == params[:id].to_i
                    no_of_following = no_of_following + 1
                elsif follow[:followed_id] == params[:id].to_i
                    no_of_followers = no_of_followers + 1
                end
            end
            @user_data = @user_data.attributes
            @user_data[:no_of_followers] = no_of_followers
            @user_data[:no_of_following] = no_of_following
            @user_data[:is_user_following] = is_user_following

            # groups user is in
            @group_data = Array.new
            Member.where(user_id: params[:id]).each { |member|
                group_id = member[:group_id]
                group = Group.find_by(id: group_id)
                group_name = group[:name]
                group_desc = group[:description]
                if group_desc.nil?
                    @group_data.push({
                        group_id: group_id,
                        group_name: group_name,
                        is_owner: member[:is_owner]
                    })
                else
                    @group_data.push({
                        group_id: group_id,
                        group_name: group_name,
                        group_desc: group_desc,
                        is_owner: member[:is_owner]
                    })
                end
            }

            plans = Plan.where(owner_id: params[:id])
            result_plans = Array.new
            plans.each { |plan|
                @like = Like.find_by(plan_id: plan[:id], user_id: @user[:id])
                @full_plan = generate_full_plan(plan)
                if @like.nil?
                    @full_plan[:is_user_like] = false
                else
                    @full_plan[:is_user_like] = true
                end
                    
                result_plans.push(@full_plan)
            }

            json_response({user_data: @user_data, user_plans: result_plans, group_data: @group_data})
        end
    end

    private

    def user_params
        params.permit(:email, :password, :name, :primary_degree, :second_degree, :second_major, :first_minor, :second_minor, :matriculation_year)
    end

    def generate_full_plan(plan)
        just_plan = Plan.find(plan.id).attributes.transform_keys(&:to_sym)
        just_plan[:semesters] = Plan.find(plan.id).semesters.map do |sem|
            sem_json = sem.attributes.transform_keys(&:to_sym)
            sem_json[:mods] = sem.mods.as_json.map{ |mod| mod.transform_keys(&:to_sym) }
            sem_json
        end
        just_plan
    end
end
