require 'rails_helper'

RSpec.describe ProductModel, type: :model do
  describe '#valid?' do
    it 'nome nao pode estar vazio' do
      supplier = Supplier.create!(fantasy_name: 'CiberTech', company_name: 'CT Technology', cnpj: '96631230001091', address: 'Rua vírginio campos, 123',
        email: 'cibertech@company.com.br', phone: '81 981316988')

      product_model = ProductModel.new(name: '', wight: 2000, width: 90, height: 30, depth: 2, sku: 'MT8000-KOREJVNERTYUO', supplier: supplier)

      expect(product_model.valid?).to eq false
    end

    it 'wigth nao pode estar vazio' do
      supplier = Supplier.create!(fantasy_name: 'CiberTech', company_name: 'CT Technology', cnpj: '96631230001091', address: 'Rua vírginio campos, 123',
        email: 'cibertech@company.com.br', phone: '81 981316988')

      product_model = ProductModel.new(name: 'Monitor 8k', wight: '', width: 90, height: 30, depth: 2, sku: 'MT8000-KOREJVNERTYUO', supplier: supplier)

      expect(product_model.valid?).to eq false
    end

    it 'width nao pode estar vazio' do
      supplier = Supplier.create!(fantasy_name: 'CiberTech', company_name: 'CT Technology', cnpj: '96631230001091', address: 'Rua vírginio campos, 123',
        email: 'cibertech@company.com.br', phone: '81 981316988')

      product_model = ProductModel.new(name: 'Monitor 8k', wight: 2000, width: '', height: 30, depth: 2, sku: 'MT8000-KOREJVNERTYUO', supplier: supplier)

      expect(product_model.valid?).to eq false
    end

    it 'height nao pode estar vazio' do
      supplier = Supplier.create!(fantasy_name: 'CiberTech', company_name: 'CT Technology', cnpj: '96631230001091', address: 'Rua vírginio campos, 123',
        email: 'cibertech@company.com.br', phone: '81 981316988')

      product_model = ProductModel.new(name: 'Monitor 8k', wight: 2000, width: 90, height: '', depth: 2, sku: 'MT8000-KOREJVNERTYUO', supplier: supplier)

      expect(product_model.valid?).to eq false
    end

    it 'depth nao pode estar vazio' do
      supplier = Supplier.create!(fantasy_name: 'CiberTech', company_name: 'CT Technology', cnpj: '96631230001091', address: 'Rua vírginio campos, 123',
        email: 'cibertech@company.com.br', phone: '81 981316988')

      product_model = ProductModel.new(name: 'Monitor 8k', wight: 2000, width: 90, height: 30, depth: '', sku: 'MT8000-KOREJVNERTYUO', supplier: supplier)

      expect(product_model.valid?).to eq false
    end

    it 'sku nao pode estar vazio' do
      supplier = Supplier.create!(fantasy_name: 'CiberTech', company_name: 'CT Technology', cnpj: '96631230001091', address: 'Rua vírginio campos, 123',
        email: 'cibertech@company.com.br', phone: '81 981316988')

      product_model = ProductModel.new(name: 'Monitor 8k', wight: 2000, width: 90, height: 30, depth: 2, sku: '', supplier: supplier)

      expect(product_model.valid?).to eq false
    end

    it 'altura nao pode ser menor que 1cm' do
      supplier = Supplier.create!(fantasy_name: 'CiberTech', company_name: 'CT Technology', cnpj: '96631230001091', address: 'Rua vírginio campos, 123',
        email: 'cibertech@company.com.br', phone: '81 981316988')

      product_model = ProductModel.new(name: 'Monitor 8k', wight: 2000, width: 90, height: -5, depth: 2, sku: 'MT8000-KOREJVNERTYUO', supplier: supplier)

      expect(product_model.valid?).to eq false
    end

    it 'peso nao pode ser menor que 1 grama' do
      supplier = Supplier.create!(fantasy_name: 'CiberTech', company_name: 'CT Technology', cnpj: '96631230001091', address: 'Rua vírginio campos, 123',
        email: 'cibertech@company.com.br', phone: '81 981316988')

      product_model = ProductModel.new(name: 'Monitor 8k', wight: 0, width: 90, height: 30, depth: 2, sku: 'MT8000-KOREJVNERTYUO', supplier: supplier)

      expect(product_model.valid?).to eq false
    end

    it 'largura nao pode ser menor que 1 cm' do
      supplier = Supplier.create!(fantasy_name: 'CiberTech', company_name: 'CT Technology', cnpj: '96631230001091', address: 'Rua vírginio campos, 123',
        email: 'cibertech@company.com.br', phone: '81 981316988')

      product_model = ProductModel.new(name: 'Monitor 8k', wight: 2000, width: -1, height: 30, depth: 2, sku: 'MT8000-KOREJVNERTYUO', supplier: supplier)

      expect(product_model.valid?).to eq false
    end

    it 'profundidade nao pode ser menor que 1 cm' do
      supplier = Supplier.create!(fantasy_name: 'CiberTech', company_name: 'CT Technology', cnpj: '96631230001091', address: 'Rua vírginio campos, 123',
        email: 'cibertech@company.com.br', phone: '81 981316988')

      product_model = ProductModel.new(name: 'Monitor 8k', wight: 2000, width: 90, height: 30, depth: 0, sku: 'MT8000-KOREJVNERTYUO', supplier: supplier)

      expect(product_model.valid?).to eq false
    end

    it 'código sku tem que ter 20 caracteres' do
      supplier = Supplier.create!(fantasy_name: 'CiberTech', company_name: 'CT Technology', cnpj: '96631230001091', address: 'Rua vírginio campos, 123',
        email: 'cibertech@company.com.br', phone: '81 981316988')

      product_model = ProductModel.new(name: 'Monitor 8k', wight: 2000, width: 90, height: 30, depth: 2, sku: 'MT80000-KOREJVNERTYUO', supplier: supplier)

      expect(product_model.valid?).to eq false
    end

    it 'código sku nao pode ser duplicado' do
      supplier = Supplier.create!(fantasy_name: 'CiberTech', company_name: 'CT Technology', cnpj: '96631230001091', address: 'Rua vírginio campos, 123',
        email: 'cibertech@company.com.br', phone: '81 981316988')

      product_model1 = ProductModel.create!(name: 'Monitor 8k', wight: 2000, width: 90, height: 30, depth: 2, sku: 'MT8000-KOREJVNERTYUO', supplier: supplier)
      product_model2 = ProductModel.new(name: 'Monitor 4k', wight: 1600, width: 90, height: 30, depth: 2, sku: 'MT8000-KOREJVNERTYUO', supplier: supplier)

      expect(product_model2.valid?).to eq false
    end
  end
end
