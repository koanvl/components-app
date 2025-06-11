class ProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user

  def show
  end

  def edit
  end

  def update
    # Handle avatar removal
    if params[:remove_avatar] == "true"
      @user.avatar.purge if @user.avatar.attached?
      redirect_to profile_path, notice: "Profile photo removed successfully."
      return
    end

    if @user.update(user_params)
      redirect_to profile_path, notice: "Profile updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def freelancer_portfolio
    @freelancer = User.find(params[:id])
    @portfolios = @freelancer.portfolios.includes(:images_attachments).order(created_at: :desc)
  end

  private

  def set_user
    @user = current_user
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :company_name, :professional_title, :bio, :avatar)
  end
end
