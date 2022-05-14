require 'rails_helper'

describe 'Usuario se autentica com sucesso' do
  it 'com sucesso' do
    #arreange
    Admin.create!(email: 'kilder@gmail.com', password: 'password')
    #act
    visit root_path
    click_on 'Entrar'
    fill_in 'E-mail', with: 'kilder@gmail.com'
    fill_in 'Senha', with: 'password'
    within('form') do
      click_on 'Entrar'
    end
    
    #assert
    expect(page).to have_content 'Login efetuado com sucesso'
    within('nav') do
      expect(page).not_to have_link 'Entrar'
      expect(page).to have_button 'Sair'
      expect(page).to have_content 'kilder@gmail.com'
    end
  end

  it 'e faz logout' do
    #arreange
    Admin.create!(email: 'kilder@gmail.com', password: 'password')
    #act
    visit root_path
    click_on 'Entrar'
    fill_in 'E-mail', with: 'kilder@gmail.com'
    fill_in 'Senha', with: 'password'
    within('form') do
      click_on 'Entrar'
    end
    click_on 'Sair'

    expect(page).to have_content 'Logout efetuado com sucesso.'
    expect(page).to have_link 'Entrar'
    expect(page).not_to have_button 'Sair'
    expect(page).not_to have_content 'kilder@gmail.com'
  end
end