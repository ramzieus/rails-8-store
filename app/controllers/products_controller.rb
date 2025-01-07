class ProductsController < ApplicationController
  allow_unauthenticated_access only: %i[ index show ]
  before_action :set_product, only: %i[ show edit update destroy ]

  # this method is an Action; even though it's empty, Rails will default to
  # rendering a template with the matching name
  def index
    # by default this method renders `app/views/products/index.html.erb`

    # adding database query and assigning it to instance var
    @products = Product.all
  end

  def show
  end

  # here, `show` defines singular `@product` because it's loading a single record
  # from the db, ie, "show this one product". 
  # we use plural `@products` in `index` because we're loading multiple products
  def show
    @product = Product.find(params[:id])
  end

  # instantiates a new Product which we will use for displaying the form fields
  def new
    @product = Product.new
  end

  # handles the data submitted by the form
  def create
    @product = Product.new(product_params)
    if @product.save
      # when `redirect_to` is given an Active Record object, Rails generates a
      # path for that record's `show` action
      redirect_to @product
    else # when the save is unsuccessful bc record not valid
      # re-renders the form so the user can fix the invalid data

      # Rails knows we're in the `Products` controller so it should render `app/views/products/new.html.erb`

      # this line also sets HTTP status to '422 unprocessable entity' to tell the
      # browser that the POST request failed and to handle it accordingly
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @product.update(product_params)
      redirect_to @product
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @product.destroy
    redirect_to products_path
  end

  # to filter for security, this is private
  private
    def set_product
      @product = Product.find(params[:id])
    end

    # here we tell rails to inspect the params and ensure there is a key named
    # `:product` with an array of parameters as the value. 
    # The only permitted parameters for products is :name and Rails will ignore
    # any other parameters.
    # This protects our application from malicious users who might try to hack our app
    def product_params
      params.expect(product: [ :name, :description, :featured_image, :inventory_count ])
    end
end
