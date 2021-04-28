# frozen_string_literal: true

require 'rails_helper'

describe 'Coupons management' do
  context 'when show' do
    it 'render copoun json with discount' do
      promotion = Promotion.create!(name: 'Cyber Monday', coupon_quantity: 100,
                                    description: 'Promoção de Cyber Monday',
                                    code: 'CYBER15', discount_rate: 15,
                                    expiration_date: '22/12/2033')
      coupon = Coupon.create!(promotion: promotion, code: 'CYBER15-001')

      get "/api/v1/coupons/#{coupon.code}"

      expect(response.status).to eq(200)
      expect(response.body).to include('15')
      expect(response.body).to include('22/12/2033')
    end

    it 'coupon not found' do
      get '/api/v1/coupons/ABCD123'

      expect(response.status).to eq(404)
      expect(response.body).to include('Cupom não encontrado')
    end
  end

  context 'when burn' do
    it 'change coupon status' do
      promotion = Promotion.create!(name: 'Cyber Monday', coupon_quantity: 100,
                                    description: 'Promoção de Cyber Monday',
                                    code: 'CYBER15', discount_rate: 15,
                                    expiration_date: '22/12/2033')
      coupon = Coupon.create!(promotion: promotion, code: 'CYBER15-0001')

      post "/api/v1/coupons/#{coupon.code}/burn", params: { order: { code: 'ORDER123' } }

      expect(response.status).to eq(200)
      expect(response.body).to include('Cupom utilizado com sucesso')
      expect(coupon.reload).to be_burn
      expect(coupon.reload.order).to eq('ORDER123')
    end

    it 'order must exist' do
      promotion = Promotion.create!(name: 'Cyber Monday', coupon_quantity: 100,
                                    description: 'Promoção de Cyber Monday',
                                    code: 'CYBER15', discount_rate: 15,
                                    expiration_date: '22/12/2033')
      coupon = Coupon.create!(promotion: promotion, code: 'CYBER15-0001')

      post "/api/v1/coupons/#{coupon.code}/burn", params: {}

      expect(response.status).to eq(412)
    end

    it 'order must exists' do
      promotion = Promotion.create!(name: 'Cyber Monday', coupon_quantity: 100,
                                    description: 'Promoção de Cyber Monday',
                                    code: 'CYBER15', discount_rate: 15,
                                    expiration_date: '22/12/2033')
      coupon = Coupon.create!(promotion: promotion, code: 'CYBER15-0001')

      post "/api/v1/coupons/#{coupon.code}/burn", params: { order: { code: '' } }

      expect(response.status).to eq(422)
    end
  end
end
