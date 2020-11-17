class Api::ApplicationController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_json_not_found_error

  def index
    resource_collection = resource_class.all
    render json: resource_collection
  end

  def show
    render json: resource, serializer: show_serializer
  end

  def create
    @resource = resource_class.new(resource_params)
    save_and_render
  end

  def resource
    @resource ||= resource_class.find(params[:id])
  end

  def save_and_render
    unless resource.save
      render_json_validation_error resource
      return
    end

    create_callback

    render json: resource, serializer: show_serializer
  end

  def create_callback; end

  def render_json_validation_error(resource)
    render json: resource, status: :bad_request, adapter: :json_api, serializer: ActiveModel::Serializer::ErrorSerializer
  end

  def render_json_not_found_error
    error = {
      title: "Resource not found",
      status: :not_found,
      code: 404
    }

    render json: { errors: [error] }, status: status
  end
end

