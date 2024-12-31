class ProductsController < ApplicationController
  # this method is an Action; even though it's empty, Rails will default to
  # rendering a template with the matching name
  def index
    # by default this method renders `app/views/products/index.html.erb`

    # adding database query and assigning it to instance var
    @products = Product.all
  end

  # here, `show` defines singular `@product` because it's loading a single record
  # from the db, ie, "show this one product". 
  # we use plural `@products` in `index` because we're loading multiple products
  def show
    @product = Product.find(params[:id])
  end
end
