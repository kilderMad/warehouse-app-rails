require 'rails_helper'

describe ' usuario cadastra um pedido' do
  it 'e deve estar autenticado' do
    visit root_path
    click_on 'Registrar Pedido'
    expect(current_path).to have_content new_admin_session_path
  end
  it 'com sucesso' do
    Supplier.create!(fantasy_name: 'CIA Tech', company_name: 'Compania e Technologia', cnpj: '9663456000109', address: 'Rua oscar raposo, 523',
      email: 'ciatech@company.com.br', phone: '81 997661256')
    supplier = Supplier.create!(fantasy_name: 'CiberTech', company_name: 'CT Technology', cnpj: '9663123000109', address: 'Rua vírginio campos, 123',
      email: 'cibertech@company.com.br', phone: '81 981316988')
    Warehouse.create!(name: 'Recife', code: 'RCF', city: 'Recife', area: 90_000,
      address: 'Avenida do aeroporto, 1000', cep: '15000-000',
      description: 'Galpao destinado para cargas internacionais') 
    warehouse = Warehouse.create!(name: 'São Paulo', code: 'GRU', city: 'Guarulhos', area: 100_000,
        address: 'Avenida do aeroporto, 1000', cep: '15000-000',
        description: 'Galpao destinado para cargas internacionais')   
    user = Admin.create!(email: 'sergio@gmail.com', password: 'password', name: 'Sergio')
    allow(SecureRandom).to receive(:alphanumeric).and_return('ABC12345')

    login_as(user)
    visit root_path
    click_on 'Registrar Pedido'
    select "GRU - São Paulo", from: 'Galpão destino'
    select supplier.fantasy_name, from: 'Fornecedor'
    fill_in 'Data prevista de entrega', with: '20/10/2022'
    click_on 'Gravar'

    expect(page).to have_content 'Status: Pendente'
    expect(page).to have_content 'Pedido registrado com sucesso'
    expect(page).to have_content 'Pedido ABC12345'
    expect(page).to have_content 'Galpão destino: GRU - São Paulo'
    expect(page).to have_content 'Fornecedor: CiberTech'
    expect(page).to have_content 'Data prevista de entrega: 20/10/2022'
    expect(page).to have_content "Usuário responsável: Sergio | sergio@gmail.com"
  end
end