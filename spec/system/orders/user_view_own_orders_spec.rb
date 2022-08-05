require 'rails_helper'

describe 'usuario ve seus propios pedidos' do
  it 'e deve estar autenticado' do
    visit root_path
    click_on 'Meus Pedidos'

    expect(current_path).to eq new_admin_session_path 
  end

  it 'e nao ve outros pedidos' do
    supplier = Supplier.create!(fantasy_name: 'CiberTech', company_name: 'CT Technology', cnpj: '96631230001091', address: 'Rua vírginio campos, 123',
      email: 'cibertech@company.com.br', phone: '81 981316988')
    warehouse = Warehouse.create!(name: 'Recife', code: 'RCF', city: 'Recife', area: 90_000,
      address: 'Avenida do aeroporto, 1000', cep: '15000-000',
      description: 'Galpao destinado para cargas internacionais')
    user = Admin.create!(name: 'joao', email: 'joao@gmail.com', password:'password')
    user2 = Admin.create!(name: 'kleber', email: 'kleber@gmail.com', password:'password')
    allow(SecureRandom).to receive(:alphanumeric).and_return('SPC00001')
    order1 = Order.create!(admin: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 2.day.from_now, status: 'pending')
    allow(SecureRandom).to receive(:alphanumeric).and_return('SPC00001')
    order2 = Order.create!(admin: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 2.day.from_now, status: 'delivered')
    allow(SecureRandom).to receive(:alphanumeric).and_return('RCF98765')
    order3 = Order.create!(admin: user2, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 3.day.from_now,status: 'canceled')
   
    login_as(user)

    visit root_path
    click_on 'Meus Pedidos'

    expect(page).to have_content order1.code
    expect(page).to have_content 'Pendente'
    expect(page).to have_content order2.code
    expect(page).to have_content 'Entregue'
    expect(page).not_to have_content order3.code
    expect(page).not_to have_content 'Cancelado'

  end

  it 'e visita um pedido' do
    supplier = Supplier.create!(fantasy_name: 'CiberTech', company_name: 'CT Technology', cnpj: '96631230001091', address: 'Rua vírginio campos, 123',
      email: 'cibertech@company.com.br', phone: '81 981316988')
    warehouse = Warehouse.create!(name: 'Recife', code: 'RCF', city: 'Recife', area: 90_000,
      address: 'Avenida do aeroporto, 1000', cep: '15000-000',
      description: 'Galpao destinado para cargas internacionais')
    user = Admin.create!(name: 'joao', email: 'joao@gmail.com', password:'password')
    user2 = Admin.create!(name: 'kilder', email: 'kilder@gmail.com', password:'password')
    allow(SecureRandom).to receive(:alphanumeric).and_return('SPC00001')
    order = Order.create!(admin: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 2.day.from_now)
    product_a = ProductModel.create!(name: 'Monitor 8k', wight: 2000, width: 90, height: 30, depth: 2, sku: 'MT8000-KOREJVNERTYUO', supplier: supplier)
    product_b = ProductModel.create!(name: 'Monitor 4k', wight: 2000, width: 90, height: 30, depth: 2, sku: 'MT4000-KOREJVNERTYUO', supplier: supplier)
    product_c = ProductModel.create!(name: 'Monitor 1080p', wight: 1000, width: 70, height: 20, depth: 2, sku: 'MT1000-KOREJVNERTYUO', supplier: supplier)
    OrderItem.create!(product_model: product_a, order: order, quantity: 20)
    OrderItem.create!(product_model: product_b, order: order, quantity: 14)
    login_as(user)

    visit root_path
    click_on 'Meus Pedidos'
    click_on order.code

    expect(page).to have_content 'Itens do Pedido'
    expect(page).to have_content '20 x Monitor 8k'
    expect(page).to have_content '14 x Monitor 4k'
    expect(page).to have_content 'Detalhes do Pedido'
    expect(page).to have_content order.code
    expect(page).to have_content 'Galpão destino: RCF - Recife'
    expect(page).to have_content 'Fornecedor: CiberTech'
    expect(page).to have_content "Data prevista de entrega: #{I18n.l(2.day.from_now.to_date)}"
    
  end

  it 'e nao visita pedidos de outros usuarios' do
    supplier = Supplier.create!(fantasy_name: 'CiberTech', company_name: 'CT Technology', cnpj: '96631230001091', address: 'Rua vírginio campos, 123',
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
    login_as(user)

    visit order_path(order3.id)
    
    expect(current_path).not_to eq order_path(order3.id)
    expect(current_path).to eq root_path
    expect(page).to have_content 'Pedido não existe'

  end
end 