class PortfoliosController < ApplicationController
  before_action :authenticate_user!
  before_action :set_portfolio, only: [ :show, :edit, :update, :destroy ]
  before_action :ensure_freelancer!, except: [ :show, :freelancer_portfolio, :index ]
  before_action :ensure_portfolio_owner!, only: [ :edit, :update, :destroy ]

  def index
    @freelancers = User.freelancer.includes(:portfolios, avatar_attachment: :blob)
  end

  def show
    # Portfolio can be viewed by anyone
  end

  def new
    @portfolio = current_user.portfolios.build
  end

  def create
    @portfolio = current_user.portfolios.build(portfolio_params)

    if @portfolio.save
      redirect_to @portfolio, notice: "Portfolio item was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    # Portfolio item loaded by before_action
  end

  def update
    if @portfolio.update(portfolio_params)
      redirect_to @portfolio, notice: "Portfolio item was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @portfolio.destroy
    redirect_to profile_path, notice: "Portfolio item was successfully deleted."
  end

  def freelancer_portfolio
    @freelancer = User.freelancer.find(params[:id])
    @portfolios = @freelancer.portfolios.recent
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path, alert: "Freelancer not found."
  end

  private

  def set_portfolio
    @portfolio = Portfolio.find(params[:id])
  end

  def ensure_freelancer!
    unless current_user&.freelancer?
      redirect_to root_path, alert: "Access denied. Only freelancers can manage portfolios."
    end
  end

  def ensure_portfolio_owner!
    unless @portfolio.user == current_user
      redirect_to root_path, alert: "Access denied. You can only manage your own portfolio items."
    end
  end

  def portfolio_params
    params.require(:portfolio).permit(:title, :description, :project_url, :technologies, images: [])
  end
end
