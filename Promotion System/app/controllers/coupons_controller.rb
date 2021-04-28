# frozen_string_literal: true

class CouponsController < ApplicationController
  def inactivate
    @coupon = Coupon.find(params[:id])
    @coupon.inactive!
    flash[:success] = t('.success')
    redirect_to @coupon.promotion
  end

  def index
    @coupons = Coupon.all
    redirect_to promotions_path, alert:'Registre uma promoção para gerar um cupom' if @coupons.nil?
  end

  def search
    @coupons = Coupon.search(params[:search])
  end

  def show
    @coupon = Coupon.find(params[:id])
    flash.now[:notice] = 'Esse cupom não existe' if @coupons.nil?
  end

  def new
    @coupon = Coupon.new
  end

  private

  def coupon_params
    params
      .require(:coupon)
      .permit(:code, :order)
  end
end
