class Profile::BaseController < ApplicationController
  before_action :require_user

  def require_user
    render file: "/public/404" if visitor?
  end
end
