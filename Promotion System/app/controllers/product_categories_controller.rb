# frozen_string_literal: true

class ProductCategoriesController < ApplicationController
  def index
    @product_categories = ProductCategory.all
    redirect_to new_product_category_path, alert: 'Esta categoria de produtos não existe' if @product_categories.empty?
  end

  def show
    @product_categories = ProductCategory.find(params[:id])
  end

  def new
    @product_categories = ProductCategory.new
  end

  def create
    @product_categories = ProductCategory.new(category_params)
    if @product_categories.save
      redirect_to @product_categories
    else
      render :new
    end
  end

  private

  def category_params
    params
      .require(:product_category)
      .permit(:name, :code)
  end
end
