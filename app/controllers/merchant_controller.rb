class MerchantController < ApplicationController
  def show
    render file: "/public/404" unless current_merchant?
  end

end
