require 'rails_helper'

describe 'Usuario busca por um pedido' do

  it 'a partir do menu' do
    user = Admin.create!(name: 'kilder', email: 'kilder@gmail.com', password:'password')
    login_as(user)
    visit root_path

    within('header nav') do
      expect(page).to have_field 'Buscar pedido'
      expect(page).to have_button 'Buscar'
    end
    
  end

  it 'e deve estar autenticado' do
    visit root_path

    within('header nav') do
      expect(page).not_to have_field 'Buscar pedido'
      expect(page).not_to have_button 'Buscar'
    end
  end

  it 'e encontra um pedido' do
    supplier = Supplier.create!(fantasy_name: 'CiberTech', company_name: 'CT Technology', cnpj: '9663123000109', address: 'Rua vírginio campos, 123',
      email: 'cibertech@company.com.br', phone: '81 981316988')
    warehouse = Warehouse.create!(name: 'Recife', code: 'RCF', city: 'Recife', area: 90_000,
      address: 'Avenida do aeroporto, 1000', cep: '15000-000',
      description: 'Galpao destinado para cargas internacionais')
    user = Admin.create!(name: 'kilder', email: 'kilder@gmail.com', password:'password')
    order = Order.create!(admin: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now)
    
    login_as(user)
    visit root_path
    fill_in 'Buscar pedido', with: order.code
    click_on 'Buscar'

    expect(page).to have_content "Resultados da busca por: #{order.code}"
    expect(page).to have_content '1 Pedido encontrado'
    expect(page).to have_content "Código: #{order.code}"
    expect(page).to have_content "Galpão destino: #{order.warehouse.full_description}"
    expect(page).to have_content "Fornecedor: #{order.supplier.fantasy_name}"
  end

  it 'e encontra multiplos pedidos' do
    supplier = Supplier.create!(fantasy_name: 'CiberTech', company_name: 'CT Technology', cnpj: '9663123000109', address: 'Rua vírginio campos, 123',
      email: 'cibertech@company.com.br', phone: '81 981316988')
    warehouse = Warehouse.create!(name: 'São paulo', code: 'SPC', city: 'São paulo', area: 90_000,
      address: 'Av do galo, 1000', cep: '12000-000',
      description: 'Galpao destinado para cargas internacionais')
    warehouse2 = Warehouse.create!(name: 'Recife', code: 'RCF', city: 'Recife', area: 90_000,
      address: 'Avenida do aeroporto, 1000', cep: '15000-000',
      description: 'Galpao destinado para cargas internacionais')
    user = Admin.create!(name: 'kilder', email: 'kilder@gmail.com', password:'password')
    allow(SecureRandom).to receive(:alphanumeric).and_return('SPC12345')
    order1 = Order.create!(admin: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now)
    allow(SecureRandom).to receive(:alphanumeric).and_return('SPC00001')
    order2 = Order.create!(admin: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 2.day.from_now)
    allow(SecureRandom).to receive(:alphanumeric).and_return('RCF98765')
    order3 = Order.create!(admin: user, warehouse: warehouse2, supplier: supplier, estimated_delivery_date: 3.day.from_now)
    
    login_as(user)
    visit root_path
    fill_in 'Buscar pedido', with: 'SPC'
    click_on 'Buscar'

    expect(page).to have_content '2 Pedidos encontrados'
    expect(page).to have_content 'SPC12345'
    expect(page).to have_content 'SPC00001'
    expect(page).not_to have_content 'RCF98765'
    expect(page).to have_content "Galpão destino: #{order1.warehouse.full_description}"
    expect(page).not_to have_content "Galpão destino: #{order3.warehouse.full_description}"

  end
  
end