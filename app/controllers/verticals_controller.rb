class VerticalsController < ApplicationController
  before_action :doorkeeper_authorize!

  def index
    render json: Vertical.all.as_json(only: [:id, :name])
  end
end
