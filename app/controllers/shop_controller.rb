class ShopController < ApplicationController
  # GET /carts
  # GET /carts.xml
  layout "shop"
  
  def index
    
  end

  def good

  end

  def get_sub_categories
    render :update do |page|
      page.replace_html "subcategories_for_"+params[:category_id], :partial=>"sub_categories_for_category"
    end
  end
end
