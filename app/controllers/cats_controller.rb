class CatsController < ApplicationController
  
  def index
    @cats = Cat.all
    render :index
  end
  
  def show
    @cats = Cat.find(params[:id])
    render :show
  end
  
  def new
    @cats = Cat.new
    render :new  
  end
  
  def create
    @cats = Cat.new(user_params)
    if @cats.save
      redirect_to cat_url(@cats)
    else
      render json: @cats.errors.full_messages, status: 422
    end 
  end
  
  def edit
    @cats = Cat.find(params[:id])
    render :edit
  end
  
  def update
    @cats = Cat.find(params[:id])
    if @cats.update(user_params)
      redirect_to cat_url(@cats)
    else
      render json: @cats.errors.full_messages, status: 422
    end
  end
  
  private
  def user_params
    params.require(:cat).permit(:name, :birth_date, :color, :sex, :description)
  end
end