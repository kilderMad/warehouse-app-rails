require "rails_helper"

describe 'Usuario acessa modelos de produtos' do

  it 'se estiver autenticado' do
    visit root_path
    click_on 'Modelos de produtos'

    expect(current_path).to eq new_admin_session_path
  end

  it 'a partir da tela inicial' do

    user = Admin.create!(email: 'kilder@gmail.com', password: 'password')

    login_as(user)
    visit root_path    
    click_on 'Modelos de produtos'

    expect(current_path).to eq product_models_path
  end

  it 'e vê modelos de produtos' do
    supplier = Supplier.create!(fantasy_name: 'CiberTech', company_name: 'CT Technology', cnpj: '9663123000109', address: 'Rua vírginio campos, 123',
                                email: 'cibertech@company.com.br', phone: '81 981316988')

    product_model = ProductModel.create!(name: 'Monitor 8k', wight: 2000, width: 90, height: 30, depth: 2, sku: 'MT8000-KOREJVNERTYUO', supplier: supplier)
    user = Admin.create!(email: 'kilder@gmail.com', password: 'password')
    login_as(user)
    visit root_path
    click_on 'Modelos de produtos'

    expect(page).to have_content 'Monitor 8k'
    expect(page).to have_content 'MT8000-KOREJVNERTYUO'
    expect(page).to have_content 'CiberTech'
  end

  it 'e nao tem modelos de produtos cadastrados' do
    user = Admin.create!(email: 'kilder@gmail.com', password: 'password')
    login_as(user)
    visit root_path
    click_on 'Modelos de produtos'

    expect(page).to have_content 'Não ha modelos cadastrados'
  end

end