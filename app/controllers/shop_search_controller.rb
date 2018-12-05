class ShopSearchController < ApplicationController
  def shopsearch
    @shops = Fixer.all
    gon.owner_address = current_user.address
    gon.shops = @shops
  end

  def showshop
    @shop = Fixer.find(params[:shop_id])
    @distance = params[:distance]
    respond_to do |format|
      format.js
    end
  end

  def filtershop
    @shops = Fixer.all
    gon.shops = @shops
    if (params[:shoplabel]!=0)
      @shops = AutoPart.find(params[:shoplabel]).fixers
    end
    if Rails.env.development?
      @filteredshops = @shops.where("name LIKE ? ","%#{params[:filtername].downcase}%")
    else
      @filteredshops = @shops.where("name ILIKE ? ","%#{params[:filtername].downcase}%")
    end
    gon.filteredshops = @filteredshops
    respond_to do |format|
      format.js
    end
  end
end
