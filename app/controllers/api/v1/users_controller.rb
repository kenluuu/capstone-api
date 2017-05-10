class Api::V1::UsersController < ApplicationController
	def index
		@users = User.all
	end

	def create
		@user = User.new(
			name: params[:name],
			email: params[:email],
			password: params[:password],
			password_confirmation: params[:password_confirmation]
		)
		if @user.save
			render :show
		else 
			render json: {errors: @user.errors.full_messages}, status: 422
		end
	end

	def show 
		@user = User.find_by(id: params[:id])
	end 

	def update
		@user = User.find_by(id: params[:id])
		@user.update(
			name: params[:name]
		)
		render :show
	end

	def login
		@user = User.find_by(email: params[:email])
		if @user && @user.authenticate(params[:password])
			render :show
		else
			render json: { errors: "Authentication failed" }, status: 422
		end 

	end

end
