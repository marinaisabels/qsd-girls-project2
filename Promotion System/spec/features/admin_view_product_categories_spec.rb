# frozen_string_literal: true

require 'rails_helper'

feature 'Admin view product categories' do
  scenario 'successfully' do
    user = create :user
    create :product_category

    visit root_path
    login_as user, scope: :user
    click_on 'Categorias de Produto'

    expect(page).to have_content('E-mail')
    expect(page).to have_content('EMAIL')
    expect(page).to have_link('Voltar', href: root_path)
  end

  scenario 'and show empty message' do
    user = create :user

    visit root_path
    login_as user, scope: :user
    click_on 'Categorias de Produto'

    expect(page).to have_content('Esta categoria de produtos não existe')
  end

  scenario 'and view details' do
    create :user
    create :product_category
    visit product_categories_path

    expect(page).to have_content('Todas as categorias de produtos:')
  end
end
