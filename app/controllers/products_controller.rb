class ProductsController < ApplicationController
  before_action :authorize, :only => [:index, :new, :edit, :create, :destroy, :update, :show ] do 
    redirect_to '/' unless current_user
  end
  
  def index
    @products = Product.all 
    render :index
  end

  def new
    @product = Product.new
    render :new
  end

  def create
     @product = Product.new(product_params)
     if @product.save
      redirect_to products_path
     else
      render :new
    end
  end

  def edit
    @product = Product.find(params[:id])
    render :edit
  end

  def show
     @product = Product.find(params[:id])
    render :show
  end

  def update
    @product = Product.find(params[:id])
    if @product.update(product_params)
      redirect_to products_path
      else
        flash[:alert] = "There was problem updating this product, please check to see you filled the form out correctly."
        render :edit
    end
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    redirect_to products_path
  end

  private
    def product_params
      params.require(:product).permit(:name, :cost, :country_of_origin)
    end

end