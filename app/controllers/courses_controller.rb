class CoursesController < ApplicationController
  before_action :doorkeeper_authorize!

  def index
    render json: Course.all.as_json(only: [:id, :name, :state, :category_id])
  end

  def show
    render json: course.as_json(only: [:id, :name, :state, :category_id])
  end

  def create
    Course.create(permitted_params)
  end

  def update
    course.update(permitted_params)
  end

  def destroy
    course.destroy
  end

  private

  def permitted_params
    params.require(:course).permit(:id, :name, :author, :state)
  end

  def course
    @course ||= Course.find(params[:id])
  end
end
