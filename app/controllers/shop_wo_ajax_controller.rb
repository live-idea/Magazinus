class ShopWoAjaxController < ApplicationController
  layout "shop_wo_ajax"

  def show_good
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @good }
    end
  end
end