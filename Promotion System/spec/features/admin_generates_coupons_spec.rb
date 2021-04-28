# frozen_string_literal: true

require 'rails_helper'

feature 'Admin generates coupons' do
  scenario 'with coupon quantity available' do
    promotion = create(:promotion)
    user = create(:user)

    login_as user, scope: :user
    visit root_path
    click_on 'Promoções'
    click_on promotion.name
    click_on 'Emitir cupons'

    expect(page).to have_current_path(promotion_path(promotion), ignore_query: true)
    expect(page).to have_content('CYBER15-0001 (disponível)')
    expect(page).to have_content('CYBER15-0002 (disponível)')
    expect(page).to have_content('CYBER15-0003 (disponível)')
    expect(page).to have_content('CYBER15-0004 (disponível)')
    expect(page).to have_content('CYBER15-0005 (disponível)')
    expect(page).to have_content('Cupons gerados com sucesso')
    expect(page).not_to have_link('Emitir cupons')
  end

  scenario 'and are already generated' do
    promotion = create(:promotion)
    coupon = promotion.coupons.create(code: 'ABCD')
    user = create(:user)

    login_as user, scope: :user
    visit promotion_path(promotion)

    expect(page).not_to have_link('Emitir cupons')
    expect(page).to have_content(coupon.code)
  end
end
