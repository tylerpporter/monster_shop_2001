class Admin::MerchantsController < Admin::BaseController
  def index

  end
  
  def show
    @merchant = Merchant.find(params[:id])
  end

end
