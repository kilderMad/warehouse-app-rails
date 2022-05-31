require 'rails_helper'

describe 'usuario vê o estoque' do
  it 'na tela de galpão' do
    user = Admin.create!(name: 'joao', email: 'joao@gmail.com', password:'password')
    warehouse = Warehouse.create(name: 'Recife PE', code: 'RCF', city: 'Recife', area: 90_000,
      address: 'Avenida Brasil, 999', cep: '50340-000',
      description: 'Galpao altamente tecnológico e com melhor gerenciamento de distribuição')
    supplier = Supplier.create!(fantasy_name: 'CiberTech', company_name: 'CT Technology', cnpj: '9663123000109', address: 'Rua vírginio campos, 123',
      email: 'cibertech@company.com.br', phone: '81 981316988')
    product_a = ProductModel.create!(name: 'Monitor 8k', wight: 2000, width: 90, height: 30, depth: 2, sku: 'MT8000-KOREJVNERTYUO', supplier: supplier)
    product_b = ProductModel.create!(name: 'Monitor 4k', wight: 2000, width: 90, height: 30, depth: 2, sku: 'MT4000-KOREJVNERTYUO', supplier: supplier)
    product_c = ProductModel.create!(name: 'Monitor 1080p', wight: 1000, width: 70, height: 20, depth: 2, sku: 'MT1000-KOREJVNERTYUO', supplier: supplier)
    order = Order.create!(admin: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 2.day.from_now)

    3.times { StockProduct.create!(product_model: product_a, order: order, warehouse: warehouse)}
    2.times { StockProduct.create!(product_model: product_b, order: order, warehouse: warehouse)}

    login_as(user)
    visit root_path
    click_on 'Recife PE'

    expect(page).to have_content 'Itens em estoque'
    expect(page).to have_content '3 x Monitor 8k'
    expect(page).to have_content '2 x Monitor 4k'
    expect(page).not_to have_content 'Monitor 1080p'

  end
end