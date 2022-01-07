class UsersController < ApplicationController
<<<<<<< HEAD
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
=======
    def index
        users = User.all
        render json: users
>>>>>>> 3f29ab899cb856f4c19ac7d548b86f68d0d238a1
    end
end
