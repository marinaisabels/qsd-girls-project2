# frozen_string_literal: true

require 'rails_helper'

feature 'Admin registers a product category' do
  scenario 'from index page' do
    create :user

    visit new_product_category_path

    expect(page).to have_content('Nome')
    expect(page).to have_content('Código')
    expect(page).to have_button('Criar categoria')
  end

  scenario 'successfully' do
    user = create :user

    visit new_product_category_path

    fill_in 'Nome', with: 'Hospedagem'
    fill_in 'Código', with: 'HOSP'
    click_on 'Criar categoria'

    expect(page).to have_content('Hospedagem')
    expect(page).to have_content('HOSP')
    expect(page).to have_link('Voltar')
  end
end
