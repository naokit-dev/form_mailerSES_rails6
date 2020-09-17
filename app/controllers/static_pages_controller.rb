class StaticPagesController < ApplicationController
  def new
    @user = User.new
  end

  def cofirm
    @user = User.new(user_params)

    # return if @user.valid?

    render :confirm
  end

  def back
    @user = User.new(user_params)

    render :new
  end

  def send_mail
    @user = User.new(user_params)
    DefaultMailer.test(@user).deliver_now
    redirect_to complete_path
  end

  def complete
  end

  private

  def user_params
    params.require(:user).permit(:name,:email)
  end

end
