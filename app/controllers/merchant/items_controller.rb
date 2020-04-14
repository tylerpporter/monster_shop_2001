class Merchant::ItemsController < Merchant::BaseController

  def index
    @merchant = current_user.merchant
  end

  def new
    @merchant = current_user.merchant
    @item = Item.new
  end

  def create
    @merchant = current_user.merchant
    @item = @merchant.items.create(item_params)
    @item.save ? flash_and_redirect(@item) : sad_path_create(@item)
  end

  def edit
    @item = current_user.merchant.items.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    params.include?(:active?) ? update_status(@item) : update_item(@item)
  end

  def destroy
    item = Item.find(params[:id])
    item.destroy
    flash_and_redirect(item)
  end

  private

  def item_params
    params.permit(:name, :description, :price, :image, :inventory)
  end

  def update_params
    params.permit(:active?)
  end

  def update_status(item)
    item.update(update_params)
    flash_and_redirect(item)
  end

  def update_item(item)
    item.update(item_params)
    item.save ? flash_and_redirect(item) : sad_path_edit(item)
  end

  def flash_and_redirect(item)
    flash[:notice] = "#{item.name} is no longer for sale" if !item.active? && params[:action] == "update"
    flash[:notice] = "#{item.name} is now available for sale" if item.active? && params[:action] == "update"
    flash[:notice] = "#{item.name} has been deleted" if params[:action] == "destroy"
    flash[:notice] = "#{item.name} has been saved" if params[:action] == "create"
    flash[:notice] = "Item with ID: #{item.id} has been updated" if params[:action] == "update" && !params.include?(:active?)
    redirect_to '/merchant/items'
  end

  def sad_path_create(item)
    flash[:error] = item.errors.full_messages.to_sentence
    render :new
  end

  def sad_path_edit(item)
    flash[:error] = item.errors.full_messages.to_sentence
    render :edit
  end

end
