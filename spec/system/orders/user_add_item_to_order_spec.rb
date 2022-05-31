require 'rails_helper'

describe 'usuario adiciona itens ao pedido' do
  it 'com sucesso' do
    user = Admin.create!(email: 'sergio@gmail.com', password: 'password', name: 'Sergio')
    supplier = Supplier.create!(fantasy_name: 'CiberTech', company_name: 'CT Technology', cnpj: '9663123000109', address: 'Rua vírginio campos, 123',
      email: 'cibertech@company.com.br', phone: '81 981316988')
    warehouse = Warehouse.create!(name: 'Recife', code: 'RCF', city: 'Recife', area: 90_000,
      address: 'Avenida do aeroporto, 1000', cep: '15000-000',
      description: 'Galpao destinado para cargas internacionais') 
    order = Order.create!(admin: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 2.day.from_now)
    product_a = ProductModel.create!(name: 'Monitor 8k', wight: 2000, width: 90, height: 30, depth: 2, sku: 'MT8000-KOREJVNERTYUO', supplier: supplier)
    product_b = ProductModel.create!(name: 'Monitor 4k', wight: 2000, width: 90, height: 30, depth: 2, sku: 'MT4000-KOREJVNERTYUO', supplier: supplier)
  
    login_as(user)
    visit root_path
    click_on 'Meus Pedidos'
    click_on order.code
    click_on 'Adicionar item'
    select 'Monitor 8k', from: 'Produto'
    fill_in 'Quantidade', with: '8'
    click_on 'Adicionar'

    expect(current_path).to eq order_path(order.id)
    expect(page).to have_content 'Item adicionado com sucesso'
    expect(page).to have_content '8 x Monitor 8k'

  end

  it 'e não ver produtos de outro fornecedor' do
    user = Admin.create!(email: 'sergio@gmail.com', password: 'password', name: 'Sergio')
    supplier1 = Supplier.create!(fantasy_name: 'CiberTech', company_name: 'CT Technology', cnpj: '9663123000109', address: 'Rua vírginio campos, 123',
      email: 'cibertech@company.com.br', phone: '81 981316988')
    supplier2 = Supplier.create!(fantasy_name: 'PlinTech', company_name: 'Plin Technology', cnpj: '2663123000109', address: 'Rua campos, 123',
      email: 'plintech@company.com.br', phone: '81 181316988')
    warehouse = Warehouse.create!(name: 'Recife', code: 'RCF', city: 'Recife', area: 90_000,
      address: 'Avenida do aeroporto, 1000', cep: '15000-000',
      description: 'Galpao destinado para cargas internacionais') 
    order = Order.create!(admin: user, warehouse: warehouse, supplier: supplier1, estimated_delivery_date: 2.day.from_now)
    product_a = ProductModel.create!(name: 'Monitor 8k', wight: 2000, width: 90, height: 30, depth: 2, sku: 'MT8000-KOREJVNERTYUO', supplier: supplier1)
    product_b = ProductModel.create!(name: 'Monitor 4k', wight: 2000, width: 90, height: 30, depth: 2, sku: 'MT4000-KOREJVNERTYUO', supplier: supplier2)

    login_as(user)
    visit root_path
    click_on 'Meus Pedidos'
    click_on order.code
    click_on 'Adicionar item'

    expect(page).to have_content 'Monitor 8k'
    expect(page).not_to have_content 'Monitor 4k'
  end
end