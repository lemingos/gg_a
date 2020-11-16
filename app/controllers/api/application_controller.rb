class Api::ApplicationController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound do |e|
    render_json_error :not_found, "#{resource_class.to_s.downcase}_not_found"
  end

  def index
    resource_collection = resource_class.all
    render json: resource_collection
  end

  def show
    render json: resource, serializer: show_serializer
  end

  def create
    resource_new = resource_class.new(resource_params)
    save_and_render(resource_new)
  end

  private

  def show_serializer
    nil
  end

  def resource
    @resource ||= resource_class.find(params[:id])
  end

  def save_and_render(resource)
    if !resource.save
      render_json_validation_error resource
      return
    end

    render json: resource.reload, serializer: show_serializer
  end

  def render_json_validation_error(resource)
    render json: resource, status: :bad_request, adapter: :json_api, serializer: ActiveModel::Serializer::ErrorSerializer
  end

  def render_json_error(status, error_code, extra = {})
    status = Rack::Utils::SYMBOL_TO_STATUS_CODE[status] if status.is_a? Symbol

    error = {
      title: I18n.t("error_messages.#{error_code}.title"),
      status: status,
      code: I18n.t("error_messages.#{error_code}.code")
    }.merge(extra)

    detail = I18n.t("error_messages.#{error_code}.detail", default: '')
    error[:detail] = detail unless detail.empty?

    render json: { errors: [error] }, status: status
  end
end

