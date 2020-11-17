class Api::V1::UsersController < Api::ApplicationController

  private

  def resource_class
    User
  end

  def show_serializer
    UserShowSerializer
  end

  def resource_params
    ActiveModelSerializers::Deserialization.jsonapi_parse(params, only: [:email], keys: {})
  end
end
