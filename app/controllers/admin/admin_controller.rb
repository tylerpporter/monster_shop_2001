class Admin::AdminController < ApplicationController
  def show
    render file: "/public/404" unless current_admin?
  end
end
