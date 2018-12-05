class ShopSearchController < ApplicationController
  def shopsearch
    @shops = Fixer.all
    gon.owner_address = current_user.address
    gon.shops = @shops
  end
end
