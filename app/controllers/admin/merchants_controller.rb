class Admin::MerchantsController < Admin::BaseController
  def index
    @merchants = Merchant.all
  end

  def show
    @merchant = Merchant.find(params[:id])
  end

  def update
    merchant = Merchant.find(params[:id])
    if merchant.enabled?
      merchant.disable
      flash[:notice] = "#{merchant.name} is now disabled"
    else
      merchant.enable
      flash[:notice] = "#{merchant.name} is now enabled"
    end
    redirect_to admin_merchants_path
  end

end
