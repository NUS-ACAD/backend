class UsersController < ApplicationController
    before_action :authorized, only: [:auto_login]

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

    private

    def user_params
        params.permit(:email, :password, :name, :primary_degree, :second_degree, :second_major, :first_minor, :second_minor, :matriculation_year)
    end
end
