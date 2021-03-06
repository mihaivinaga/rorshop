class Admin::ProductsController < ApplicationController
  def index
    @search = Product.search do
      fulltext params[:search]
      order_by :updated_at, :desc
      paginate :page => params[:page], :per_page => 10
    end
    @results = @search.results
  end

  def show
    @product = Product.find params[:id]
  end

  def edit
    @product = Product.find params[:id]
    @product.images.build
    @types = Type.all
  end

  def new
    @product = Product.new
    @product.images.build
    @types = Type.all
  end

  def create
    @types = Type.all
    @product = Product.new(product_params)
    if @product.save
      redirect_to polymorphic_path([:admin, @product]),
        :flash => {:success => 'Produsul a fost salvat'}
    else
      flash[:error] = 'Produsul nu a fost salvat'
      render action: 'new'
    end
  end

  def update
    @product = Product.find params[:id]
    @types = Type.all
    if @product.update(product_params)
      redirect_to polymorphic_path([:admin, @product]),
        :flash => {:success => 'Produsul a fost salvat'}
    else
      flash[:error] = 'Produsul nu a fost salvat'
      render action: 'edit'
    end
  end

  def destroy
    @product = Product.find params[:id]
    if @product.destroy
      redirect_to admin_products_path, :flash => { :success => 'Produsul a fost sters' }
    else

    end
  end

  private

    def product_params
      params.require(:product).permit(:name, :description, :price,
        :type_value_ids => [], images_attributes: [:image])
    end

end
