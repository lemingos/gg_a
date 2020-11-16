class Api::V1::UsersController < Api::ApplicationController

  private

  def resource_class
    User
  end
end
