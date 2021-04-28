# frozen_string_literal: true

require 'rails_helper'
feature 'admin visit coupons' do
  scenario 'and search for coupon' do
    coupon = create :coupon, :with_promotion
    coupon.promotion
    user = create(:user)

    visit root_path
    login_as user, scope: :user
    fill_in 'Digite o número do Cupom:', with: 'PASCOA10'
    click_on 'Buscar Cupom'

    expect(page).to have_content('PASCOA10')
  end

  scenario 'and coupon not exists' do
    user = create(:user)

    visit root_path
    login_as user, scope: :user
    fill_in 'Digite o número do Cupom:', with: ''
    click_on 'Buscar Cupom'

    expect(page).to have_content('Esse cupom não está cadastrado')
  end
end
