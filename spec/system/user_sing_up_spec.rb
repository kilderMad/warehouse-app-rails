require 'rails_helper'

describe 'Usuario se autentica' do
  it 'com sucesso' do
    #arrange

    #act
    visit root_path
    click_on 'Entrar'
    click_on 'Criar uma conta'
    fill_in 'Nome', with: 'kilder'
    fill_in 'E-mail', with: 'kilder@live.com'
    fill_in 'Senha', with: '123456'
    fill_in 'Confirme sua senha', with: '123456'
    click_on 'Criar conta'
    #assert
    expect(page).to have_content 'Bem vindo! Você realizou seu registro com sucesso.'
    expect(page).to have_content 'kilder@live.com'
    expect(page).to have_button 'Sair'
    expect(Admin.last.name).to eq 'kilder'
  end
end