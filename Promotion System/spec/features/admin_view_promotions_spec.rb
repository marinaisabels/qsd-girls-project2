# frozen_string_literal: true

require 'rails_helper'

feature 'Admin view promotions' do
  scenario 'successfully' do
    Promotion.create!(name: 'Natal', description: 'Promoção de Natal',
                      code: 'NATAL10', discount_rate: 10, coupon_quantity: 100,
                      expiration_date: '22/12/2033')
    Promotion.create!(name: 'Cyber Monday', coupon_quantity: 100,
                      description: 'Promoção de Cyber Monday',
                      code: 'CYBER15', discount_rate: 15,
                      expiration_date: '22/12/2033')
    user = create(:user)

    login_as user, scope: :user
    visit root_path
    click_on 'Promoções'

    expect(page).to have_content('Natal')
    expect(page).to have_content('Promoção de Natal')
    expect(page).to have_content('10,00%')
    expect(page).to have_content('Cyber Monday')
    expect(page).to have_content('Promoção de Cyber Monday')
    expect(page).to have_content('15,00%')
    expect(page).not_to have_content('Nenhuma promoção cadastrada')
    expect(page).to have_link('Voltar', href: root_path)
  end

  scenario 'and view details' do
    user = create(:user)
    promotion = create(:promotion, name: 'Cyber Monday', coupon_quantity: 90,
                                   description: 'Promoção de Cyber Monday',
                                   code: 'CYBER15', discount_rate: 15,
                                   expiration_date: '22/12/2033')

    login_as user, scope: :user
    visit root_path
    click_on 'Promoções'
    visit promotions_path
    click_on promotion.name

    expect(page).to have_content('Cyber Monday')
    expect(page).to have_content('Promoção de Cyber Monday')
    expect(page).to have_content('15,00%')
    expect(page).to have_content('CYBER15')
    expect(page).to have_content('22/12/2033')
    expect(page).to have_content('90')
  end

  scenario 'and no promotion are created' do
    user = create(:user)

    login_as user, scope: :user
    visit root_path
    click_on 'Promoções'

    expect(page).to have_content('Nenhuma promoção cadastrada')
  end

  scenario 'and return to home page' do
    promotion = create(:promotion)
    user = create(:user)

    login_as user, scope: :user
    visit root_path
    click_on 'Promoções'
    click_on 'Voltar'

    expect(page).to have_current_path root_path, ignore_query: true
  end

  scenario 'and return to promotions page' do
    promotion = create(:promotion)
    user = create(:user)

    login_as user, scope: :user
    visit root_path
    click_on 'Promoções'
    click_on promotion.name
    click_on 'Voltar'

    expect(page).to have_current_path promotions_path, ignore_query: true
  end

  scenario 'and cannot view details unless logged in via link' do
    visit root_path
    click_on 'Promoções'

    expect(page).to have_content('Para continuar, efetue login ou registre-se.')
  end
end
