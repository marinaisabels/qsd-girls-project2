# frozen_string_literal: true

require 'rails_helper'

feature 'Admin inactive coupon' do
  scenario 'sucessfully' do
    promotion = Promotion.create!(name: 'Cyber Monday', coupon_quantity: 100,
                                  description: 'Promoção de Cyber Monday',
                                  code: 'CYBER15', discount_rate: 15,
                                  expiration_date: '22/12/2033')
    coupon = Coupon.create!(promotion: promotion, code: 'CYBER15-001')
    user = create(:user)

    login_as user, scope: :user
    visit promotion_path(promotion)
    click_on 'Descartar cupom'

    expect(page).to have_content('Cupom cancelado com sucesso')
    expect(page).to have_content('CYBER15-001 (cancelado)')
    expect(page).not_to have_link('Descartar cupom')
    expect(coupon.reload).to be_inactive
  end
end
