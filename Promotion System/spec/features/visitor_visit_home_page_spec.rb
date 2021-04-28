# frozen_string_literal: true

require 'rails_helper'

feature 'Visitor visit home page' do
  scenario 'successfully' do
    visit root_path

    expect(page).to have_content('Bem vindo ao sistema de gestão de promoções')
    expect(page).to have_content('Digite o número do Cupom:')
    expect(page).to have_button('Buscar Cupom')
  end
end
