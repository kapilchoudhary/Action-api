class Api::V1::UsersController < ApplicationController
  def index
    @users =  params[:search].present? ? user_query : User.all
    render json: @users, each_serializer: UserSerializer
  end

  private
  def set_params
    params.require(:user).permit(:first_name, :last_name ,:born_on, :is_admin)
  end

  def user_query
    User.where("lower(last_name) LIKE ?", "#{params[:search]}%")
  end
end
