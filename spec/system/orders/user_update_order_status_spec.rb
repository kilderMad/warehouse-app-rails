require 'rails_helper'

describe 'usuarui informa novo status de pedido ' do
  it 'e pedido foi entregue' do
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
    order = Order.create!(admin: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 2.day.from_now, status: :pending)

    login_as(user)
    visit root_path
    click_on 'Meus Pedidos'
    click_on order.code
    click_on 'Entregue'

    expect(current_path).to eq order_path(order.id)
    expect(page).to have_content 'Status: Entregue'
  end

  it 'e pedido foi entregue' do
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
    order = Order.create!(admin: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 2.day.from_now, status: :pending)

    login_as(user)
    visit root_path
    click_on 'Meus Pedidos'
    click_on order.code
    click_on 'Cancelado'

    expect(current_path).to eq order_path(order.id)
    expect(page).to have_content 'Status: Cancelado'
  end
end