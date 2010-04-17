class CartItemsController < ApplicationController
  # GET /cart_items
  # GET /cart_items.xml
#  before_filter :get_cart
#
#  def get_cart
#    @cart = session[:cart] ? Cart.find_by_id(session[:cart]) : nil
#  end


  def index
    @cart_items = CartItem.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @cart_items }
    end
  end

  # GET /cart_items/1
  # GET /cart_items/1.xml
  def show
    @cart_item = CartItem.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @cart_item }
    end
  end

  # GET /cart_items/new
  # GET /cart_items/new.xml
  def new
    @cart_item = CartItem.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @cart_item }
    end
  end

  # GET /cart_items/1/edit
  def edit
    @cart_item = CartItem.find(params[:id])
  end

  # POST /cart_items
  # POST /cart_items.xml
  def create
    @good = Good.find(params[:good_id])

    # find cart item with same good
    @cart_item_w_same_product = @cart.cart_items.find_by_good_id(@good.id)

    # if not found add cart item or increase counter otherwise
    if @cart_item_w_same_product.nil?
      @cart_item = CartItem.new
      @cart_item.quantity = 1
      @cart_item.good = @good
    else
      @cart_item_w_same_product.quantity+=1
      @cart_item = @cart_item_w_same_product
    end

    @cart_item.save

    @cart.cart_items << @cart_item

    @cart.save
    # save to session
    session[:cart]=@cart.id

    #refresh cart
    render :update do |page|
      page.replace_html "cart", :partial=>"carts/cart"
    end
  end

  # PUT /cart_items/1
  # PUT /cart_items/1.xml
  def update
    @cart_item = CartItem.find(params[:id])

    respond_to do |format|
      if @cart_item.update_attributes(params[:cart_item])
        flash[:notice] = 'CartItem was successfully updated.'
        format.html { redirect_to(@cart_item) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @cart_item.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /cart_items/1
  # DELETE /cart_items/1.xml
  def destroy
    @cart_item = CartItem.find(params[:id])
    @cart_item.destroy

    respond_to do |format|
      format.html { redirect_to(cart_items_url) }
      format.xml  { head :ok }
    end
  end
end
