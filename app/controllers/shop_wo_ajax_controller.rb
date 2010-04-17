class ShopWoAjaxController < ApplicationController
  layout "shop_wo_ajax"


  def show_good
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @good }
    end
  end

  def add_cart_item
    @good = Good.find(params[:good_id])
    cart_item = Cart_item.new
    cart_item.good = @good
    @cart.cart_items << cart_item

    # save to session
    session[:cart]=@cart
    render :update do |page|
      page.replace_html "cart", :partial=>"add_cart_item"
    end
  end
end