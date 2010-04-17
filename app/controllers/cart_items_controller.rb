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
  # Adds item to cart, if same good was added before, increases counter
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
    render_cart
  end

  # PUT /cart_items/1
  # PUT /cart_items/1.xml
  def update
    @cart_item = CartItem.find(params[:id])
    @direction = params[:direction]
    @items_change_quantity = params[:quantity]

    if @direction=="+"
      @cart_item.quantity += @items_change_quantity.to_i
    else #decreasing cart item quantity
      if @cart_item.quantity<=@items_change_quantity.to_i
        @cart_item.destroy
      else # if decreasing cart item quantity NOT to 0
        @cart_item.quantity-=@items_change_quantity.to_i
      end
    end
    @cart_item.save
    
    #refresh cart
    render_cart
  end

  # DELETE /cart_items/1
  # DELETE /cart_items/1.xml
  def destroy
    @cart_item = CartItem.find(params[:id])
    @cart_item.destroy

    #refresh cart
    render_cart
  end


  private
  def render_cart
    render :update do |page|
      page.replace_html "cart", :partial=>"carts/cart"
    end
  end
end
