class CartsController < ApplicationController
  layout "shop_wo_ajax"
  # GET /carts
  # GET /carts.xml
  def index
    @carts = Cart.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @carts }
    end
  end

  # GET /carts/1
  # GET /carts/1.xml
  def show
    @cart = Cart.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @cart }
    end
  end

  # GET /carts/new
  # GET /carts/new.xml
  def new
    @cart = Cart.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @cart }
    end
  end

  # GET /carts/1/edit
  def edit
    @cart = Cart.find(params[:id])
  end

  # POST /carts
  # POST /carts.xml
  def create
    @cart = Cart.new(params[:cart])

    respond_to do |format|
      if @cart.save
        flash[:notice] = 'Cart was successfully created.'
        format.html { redirect_to(@cart) }
        format.xml  { render :xml => @cart, :status => :created, :location => @cart }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @cart.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /carts/1
  # PUT /carts/1.xml
  def update
    @cart = Cart.find(params[:id])

    respond_to do |format|
      if @cart.update_attributes(params[:cart])
        flash[:notice] = 'Cart was successfully updated.'
        format.html { redirect_to(@cart) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @cart.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /carts/1
  # DELETE /carts/1.xml
  def destroy
    @cart = Cart.find(params[:id])
    @cart.destroy

    respond_to do |format|
      format.html { redirect_to(carts_url) }
      format.xml  { head :ok }
    end
  end

  #clears all cart
  def clear
    @cart.cart_items.clear
    #refresh cart
    render :update do |page|
      page.replace_html "cart", :partial=>"cart"
    end
  end

  # Paypal confirms transaction by this method(you should add link to it to button)
  # so you can mark payment as succesful
  def notify
    notify = Paypal::Notification.new(request.raw_post)
    @cart = Cart.find(notify.item_id)
    #enrollment = Enrollment.find(notify.item_id)

    if notify.acknowledge
      @payment = Payment.find_by_confirmation(notify.transaction_id) ||
        enrollment.invoice.payments.create(:amount => notify.amount,
        :payment_method => 'paypal', :confirmation => notify.transaction_id,
        :description => notify.params['item_name'], :status => notify.status,
        :test => notify.test?)
      begin
        if notify.complete?
          @payment.status = notify.status
        else
          logger.error("Failed to verify Paypal's notification, please investigate")
        end
      rescue => e
        @payment.status = 'Error'
        raise
      ensure
        @payment.save
      end
    end
    render :nothing => true
  end

  # show user processed order
  def cart_was_purchased
    #delete cart from session
    session[:cart]=nil

    respond_to do |format|
      format.html 
      format.xml  { render :xml => @cart }
    end
  end
end
