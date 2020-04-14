class Admin::MerchantsController < Admin::BaseController
  def index
    @merchants = Merchant.all
  end

  def show
    @merchant = Merchant.find(params[:id])
  end

  def update
    merchant = Merchant.find(params[:id])
    merchant.enabled? ?  disable(merchant) : enable(merchant)
    redirect_to admin_merchants_path
  end

  private

  def enable(merchant)
    merchant.enable
    flash[:notice] = "#{merchant.name} is now enabled"
  end

  def disable(merchant)
    merchant.disable
    flash[:notice] = "#{merchant.name} is now disabled"
  end

end
