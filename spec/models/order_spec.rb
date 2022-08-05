require 'rails_helper'

RSpec.describe Order, type: :model do
  describe '#valid?' do
    it 'deve ter um codigo' do
      order = Order.new
      order.valid?
      expect(order.errors.include? :code).to eq false
    end

    it 'data estimada de entrega deve ser obrigatoria' do
      order = Order.new(estimated_delivery_date: '')
      order.valid?
      expect(order.errors.include? :estimated_delivery_date).to eq true
    end

    it 'data estimada de entrega nao deve ser hoje' do
      order = Order.new(estimated_delivery_date: Date.today)
      order.valid?
      expect(order.errors.include? :estimated_delivery_date).to eq true
      expect(order.errors[:estimated_delivery_date]).to include(' deve ser futura.')
    end

    it 'data estimada de entrega nao deve ser igual ou maior que amanhã' do
      order = Order.new(estimated_delivery_date: 1.day.from_now)
      order.valid?
      expect(order.errors.include? :estimated_delivery_date).to eq false
    end

    it 'data estimada de entrega nao deve ser passada' do
      order = Order.new(estimated_delivery_date: 1.day.ago)
      order.valid?
      expect(order.errors.include? :estimated_delivery_date).to eq true
      expect(order.errors[:estimated_delivery_date]).to include(' deve ser futura.')
    end
  end
  describe 'gera um codigo aleatorio' do
    it 'ao criar um novo pedido' do
      user = Admin.create!(email: 'sergio@gmail.com', password: 'password', name: 'Sergio')
      supplier = Supplier.create!(fantasy_name: 'CiberTech', company_name: 'CT Technology', cnpj: '96631230001091',
                                  address: 'Rua vírginio campos, 123',
                                  email: 'cibertech@company.com.br', phone: '81 981316988')
      warehouse = Warehouse.create!(name: 'São Paulo', code: 'GRU', city: 'Guarulhos', area: 100_000,
                                    address: 'Avenida do aeroporto, 1000', cep: '15000-000',
                                    description: 'Galpao destinado para cargas internacionais')
      order = Order.new(warehouse: warehouse, admin: user, supplier: supplier, estimated_delivery_date: '2022-10-01')

      order.save!
      result = order.code

      expect(result).not_to be_empty
      expect(result.length).to eq 8
    end

    it 'e o codigo é unico' do
      user = Admin.create!(email: 'sergio@gmail.com', password: 'password', name: 'Sergio')
      supplier = Supplier.create!(fantasy_name: 'CiberTech', company_name: 'CT Technology', cnpj: '96631230001091',
                                  address: 'Rua vírginio campos, 123',
                                  email: 'cibertech@company.com.br', phone: '81 981316988')
      warehouse = Warehouse.create!(name: 'São Paulo', code: 'GRU', city: 'Guarulhos', area: 100_000,
                                    address: 'Avenida do aeroporto, 1000', cep: '15000-000',
                                    description: 'Galpao destinado para cargas internacionais')
      first_order = Order.create!(warehouse: warehouse, admin: user, supplier: supplier,
                                  estimated_delivery_date: '2022-10-01')
      second_order = Order.new(warehouse: warehouse, admin: user, supplier: supplier,
                               estimated_delivery_date: '2022-12-11')

      second_order.save!

      expect(second_order.code).not_to eq first_order.code
    end
  end
end
