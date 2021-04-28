# frozen_string_literal: true

require 'rails_helper'

feature 'Admin registers a valid promotion' do
  scenario 'and attributes cannot be blank' do
    user = create(:user)

    visit new_promotion_path
    click_on 'Criar promoção'

    expect(page).to have_content('não pode ficar em branco', count: 5)
  end
end
