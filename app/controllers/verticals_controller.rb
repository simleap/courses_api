class VerticalsController < ApplicationController
  before_action :doorkeeper_authorize!

  def index
    render json: Vertical.all.as_json(only: [:id, :name])
  end

  def show
    render json: vertical.as_json(only: [:id, :name])
  end

  def create
    Vertical.create(permitted_params)
  end

  def update
    vertical.update(permitted_params)
  end

  def destroy
    vertical.destroy
  end

  private

  def permitted_params
    params.require(:vertical).permit(:id, :name, categories_attributes: [:id, :name, :state])
  end

  def vertical
    @vertical ||= Vertical.find(params[:id])
  end
end
