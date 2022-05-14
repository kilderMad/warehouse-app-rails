require 'rails_helper'

describe 'Usuario cadastra um modelo de produto' do
  it 'com sucesso' do
    supplier = Supplier.create!(fantasy_name: 'CiberTech', company_name: 'CT Technology', cnpj: '9663123000109', address: 'Rua vírginio campos, 123',
      email: 'cibertech@company.com.br', phone: '81 981316988')
    user = Admin.create!(email: 'kilder@gmail.com', password: 'password')
    login_as(user)
    visit root_path
    click_on 'Modelos de produtos'
    click_on 'Cadastrar modelo'

    select 'CiberTech', from: 'Fornecedor'
    fill_in 'Produto', with: 'Monitor 8k'
    fill_in 'Peso', with: '2000'
    fill_in 'Largura', with: '90'
    fill_in 'Altura', with: '30'
    fill_in 'Profundidade', with: '2'
    fill_in 'SKU', with: 'MT8000-KOREJVNERTYUO'
    click_on 'Enviar'

    expect(current_path).to eq product_model_path(1)
    expect(page).to have_content 'Monitor 8k'
    expect(page).to have_content 'Código SKU: MT8000-KOREJVNERTYUO'
    expect(page).to have_content 'Fornecedor: CiberTech'
    expect(page).to have_content 'Peso: 2000 gramas'
    expect(page).to have_content 'Dimensões: 90cm x 30cm x 2cm'
    expect(page).to have_content 'Modelo de produto cadastrado com sucesso'
  end

  it 'com dados em branco' do
    supplier = Supplier.create!(fantasy_name: 'CiberTech', company_name: 'CT Technology', cnpj: '9663123000109', address: 'Rua vírginio campos, 123',
      email: 'cibertech@company.com.br', phone: '81 981316988')
    
    user = Admin.create!(email: 'kilder@gmail.com', password: 'password')
    login_as(user)
    visit root_path
    click_on 'Modelos de produtos'
    click_on 'Cadastrar modelo'
    click_on 'Enviar'

    expect(page).to have_content 'Falha ao cadastrar, preencha os dados corretamente'
  end
end