class GoodsController < ApplicationController
  # GET /goods
  # GET /goods.xml

  before_filter :current_category
  before_filter :current_good

  def current_category
      @category = Category.find_by_id(params[:category_id]) unless params[:category_id].nil?
  end

  def current_good
      @good = Good.find_by_id(params[:id]) unless params[:id].nil?
  end

  def index
    #@goods = Good.all

    if (params[:category_id])
      @goods = Good.find_all_by_category_id(params[:category_id])
    else
      @goods = Good.find(:all, :conditions=>["category_id IS NULL"])
    end

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @goods }
    end
  end

  # GET /goods/1
  # GET /goods/1.xml
  def show
    render :update do |page|
      page.replace_html :good_details, :partial=>"details"
    end
  end

  # GET /goods/new
  # GET /goods/new.xml
  def new
    @good = Good.new

    @good.fuimage = Fuimage.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @good }
    end
  end

  # GET /goods/1/edit
  def edit
    @good = Good.find(params[:id])

    #to enable adding image on edit form
    if @good.fuimage.nil?
          @good.fuimage = Fuimage.new
    end
  end

  # POST /goods
  # POST /goods.xml
  def create
    @good = Good.new(params[:good])

    respond_to do |format|
      if @good.save
        flash[:notice] = 'Good was successfully created.'
        format.html { redirect_to(category_goods_path(@category)) }
        format.xml  { render :xml => @good, :status => :created, :location => @good }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @good.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /goods/1
  # PUT /goods/1.xml
  def update
    @good = Good.find(params[:id])

    respond_to do |format|
      if @good.update_attributes(params[:good])
        flash[:notice] = 'Good was successfully updated.'
        format.html { redirect_to(category_goods_path(params[:category_id])) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @good.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /goods/1
  # DELETE /goods/1.xml
  def destroy
    @good = Good.find(params[:id])
    @good.destroy

    respond_to do |format|
      format.html { redirect_to(category_goods_path(@category)) }
      format.xml  { head :ok }
    end
  end

  def priceforyou
    @good = Good.find(params[:id])

    render :update do |page|
      page.replace_html :good_details, :partial=>"priceforyou"
      page.visual_effect :highlight, :good_details
    end
  end
end
