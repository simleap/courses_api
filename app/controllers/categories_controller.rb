class CategoriesController < ApplicationController
  before_action :doorkeeper_authorize!

  def index
    render json: Category.all.as_json(only: [:id, :name, :state])
  end

  def show
    render json: category.as_json(only: [:id, :name, :state])
  end

  def create
    Category.create(permitted_params)
  end

  def update
    category.update(permitted_params)
  end

  def destroy
    category.destroy
  end

  private

  def permitted_params
    params.require(:category).permit(:id, :name, :state, courses_attributes: [:id, :name, :author, :state])
  end

  def category
    @category ||= Category.find(params[:id])
  end
end
