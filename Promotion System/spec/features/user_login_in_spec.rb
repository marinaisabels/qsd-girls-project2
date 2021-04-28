# frozen_string_literal: true

require 'rails_helper'

feature 'User log in' do
  scenario 'and receive welcome message' do
    user = create(:user)

    visit root_path
    click_on 'Login'
    visit new_user_session_path
    fill_in 'Email:', with: user.email
    fill_in 'Senha:', with: user.password

    within 'form' do
      click_on 'Log in'
    end

    expect(page).to have_current_path(root_path, ignore_query: true)
    expect(page).to have_content('Login efetuado com sucesso!')
    expect(page).not_to have_link('Log in')
  end

  scenario 'and log out' do
    user = create(:user)

    visit root_path
    click_on 'Sair'

    expect(page).to have_current_path(root_path, ignore_query: true)
    expect(page).to have_content('Saiu com sucesso.')
    expect(page).not_to have_content('jane_doe@locaweb.com.br')
    expect(page).to have_link('Login')
    expect(page).to have_link('Sair')
  end
end
