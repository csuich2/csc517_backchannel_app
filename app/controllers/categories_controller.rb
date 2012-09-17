class CategoriesController < ApplicationController
  before_filter :authenticate_user, :assert_is_admin_user

  # GET /categories
  def index
    @categories = Category.all

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  # GET /categories/new
  def new
    @category = Category.new

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # POST /categories
  def create
    @category = Category.new(params[:category])

    respond_to do |format|
      if @category.save
        flash[:notice] = 'Category was successfully created.'
        flash[:color] = 'valid'
        format.html { redirect_to :action => "index" }
      else
        format.html { render :action => "new" }
      end
    end
  end

  # DELETE /categories/1
  def destroy
    @category = Category.find(params[:id])
    @category.destroy

    respond_to do |format|
      format.html { redirect_to categories_url }
    end
  end
end
