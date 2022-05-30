require 'rails_helper'

describe 'usuario edita pedio' do
  it 'e deve estar autenticado' do
    supplier = Supplier.create!(fantasy_name: 'CiberTech', company_name: 'CT Technology', cnpj: '9663123000109', address: 'Rua vírginio campos, 123',
      email: 'cibertech@company.com.br', phone: '81 981316988')
    warehouse = Warehouse.create!(name: 'Recife', code: 'RCF', city: 'Recife', area: 90_000,
      address: 'Avenida do aeroporto, 1000', cep: '15000-000',
      description: 'Galpao destinado para cargas internacionais')
    user = Admin.create!(name: 'joao', email: 'joao@gmail.com', password:'password')
    user2 = Admin.create!(name: 'kilder', email: 'kilder@gmail.com', password:'password')
    allow(SecureRandom).to receive(:alphanumeric).and_return('SPC00001')
    order2 = Order.create!(admin: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 2.day.from_now)
    allow(SecureRandom).to receive(:alphanumeric).and_return('RCF98765')
    order3 = Order.create!(admin: user2, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 3.day.from_now)

    visit edit_order_path(order2.id)

    expect(current_path).to eq new_admin_session_path
  end

  it 'com sucesso' do
    supplier = Supplier.create!(fantasy_name: 'CiberTech', company_name: 'CT Technology', cnpj: '9663123000109', address: 'Rua vírginio campos, 123',
      email: 'cibertech@company.com.br', phone: '81 981316988')
    supplier2 = Supplier.create!(fantasy_name: 'PliTech', company_name: 'Pli Technology', cnpj: '1163123000109', address: 'Av dinio campos, 123',
      email: 'plitech@company.com.br', phone: '81 481316988')
    warehouse = Warehouse.create!(name: 'Recife', code: 'RCF', city: 'Recife', area: 90_000,
      address: 'Avenida do aeroporto, 1000', cep: '15000-000',
      description: 'Galpao destinado para cargas internacionais')
    user = Admin.create!(name: 'joao', email: 'joao@gmail.com', password:'password')
    user2 = Admin.create!(name: 'kilder', email: 'kilder@gmail.com', password:'password')
    allow(SecureRandom).to receive(:alphanumeric).and_return('SPC00001')
    order2 = Order.create!(admin: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 2.day.from_now)
    allow(SecureRandom).to receive(:alphanumeric).and_return('RCF98765')
    order3 = Order.create!(admin: user2, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 3.day.from_now)
    login_as(user)

    visit root_path
    click_on 'Meus Pedidos'
    click_on order2.code
    click_on 'Editar'

    fill_in 'Data prevista de entrega', with: '20/12/2022'
    select 'PliTech', from: 'Fornecedor'
    click_on 'Gravar'

    expect(page).to have_content 'Galpão destino: RCF - Recife'
    expect(page).to have_content 'Fornecedor: PliTech'
    expect(page).to have_content 'Data prevista de entrega: 20/12/2022'
  end

  it 'caso seja o responsavel' do
    supplier = Supplier.create!(fantasy_name: 'CiberTech', company_name: 'CT Technology', cnpj: '9663123000109', address: 'Rua vírginio campos, 123',
      email: 'cibertech@company.com.br', phone: '81 981316988')
    warehouse = Warehouse.create!(name: 'Recife', code: 'RCF', city: 'Recife', area: 90_000,
      address: 'Avenida do aeroporto, 1000', cep: '15000-000',
      description: 'Galpao destinado para cargas internacionais')
    user = Admin.create!(name: 'joao', email: 'joao@gmail.com', password:'password')
    user2 = Admin.create!(name: 'kilder', email: 'kilder@gmail.com', password:'password')
    allow(SecureRandom).to receive(:alphanumeric).and_return('SPC00001')
    order2 = Order.create!(admin: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 2.day.from_now)
    allow(SecureRandom).to receive(:alphanumeric).and_return('RCF98765')
    order3 = Order.create!(admin: user2, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 3.day.from_now)
    login_as(user2)

    visit edit_order_path(order2.id)

    expect(current_path).to eq root_path
  end
end