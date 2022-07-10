require 'rails_helper'

describe 'Stock_product Api' do
  context 'POST api/v1/stock_product/1' do
    it 'delete success' do
      user = Admin.create!(name: 'joao', email: 'joao@gmail.com', password: 'password')
      warehouse = Warehouse.create(name: 'Recife PE', code: 'RCF', city: 'Recife', area: 90_000,
                                   address: 'Avenida Brasil, 999', cep: '50340-000',
                                   description: 'Galpao altamente tecnológico e com melhor gerenciamento de distribuição')
      supplier = Supplier.create!(fantasy_name: 'CiberTech', company_name: 'CT Technology', cnpj: '9663123000109', address: 'Rua vírginio campos, 123',
                                  email: 'cibertech@company.com.br', phone: '81 981316988')
      product_a = ProductModel.create!(name: 'Monitor 8k', wight: 2000, width: 90, height: 30, depth: 2, sku: 'MT8000-KOREJVNERTYUO', supplier: supplier)
      order = Order.create!(admin: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 2.day.from_now)
      3.times { StockProduct.create!(product_model: product_a, order: order, warehouse: warehouse) }

      post '/api/v1/stock_update', params: { ids: [1, 2, 3] }

      expect(StockProduct.count).to eq 0
    end
  end
end
