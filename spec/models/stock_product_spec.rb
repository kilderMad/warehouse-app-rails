require 'rails_helper'

RSpec.describe StockProduct, type: :model do
  describe "gera um numero de serie" do
    it 'ao criar um StockProduct' do
      user = Admin.create!(email: 'sergio@gmail.com', password: 'password', name: 'Sergio')
      supplier = Supplier.create!(fantasy_name: 'CiberTech', company_name: 'CT Technology', cnpj: '96631230001091', address: 'Rua vírginio campos, 123',
        email: 'cibertech@company.com.br', phone: '81 981316988')      
      warehouse = Warehouse.create!(name: 'São Paulo', code: 'GRU', city: 'Guarulhos', area: 100_000,
          address: 'Avenida do aeroporto, 1000', cep: '15000-000',
          description: 'Galpao destinado para cargas internacionais') 
      order = Order.create!(status: :delivered, warehouse: warehouse, admin: user, supplier: supplier, estimated_delivery_date: 1.week.from_now)
      product = ProductModel.create!(name: 'Monitor 8k', wight: 2000, width: 90, height: 30, depth: 2, sku: 'MT8000-KOREJVNERTYUO', supplier: supplier)

      stock_product = StockProduct.create!(warehouse: warehouse, product_model: product, order: order)

      expect(stock_product.serial_number.length).to eq 20
    end
  end
end
