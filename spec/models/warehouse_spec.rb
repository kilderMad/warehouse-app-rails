require 'rails_helper'

RSpec.describe Warehouse, type: :model do
  describe '#valid?' do
    it 'quando nome é vazio' do
        warehouse =Warehouse.new(name: '', code: 'RCF', address: 'Endereço',
            cep: '12500-000', city: 'Rio', area: 100000,
            description: 'alguma')

        expect(warehouse.valid?).to eq false
    end

    it 'quando codigo é vazio' do
        warehouse =Warehouse.new(name: 'Recife', code: '', address: 'Endereço',
            cep: '12500-000', city: 'Rio', area: 100000,
            description: 'alguma')

        expect(warehouse.valid?).to eq false
    end

    it 'quando address é vazio' do
        warehouse =Warehouse.new(name: 'Recife', code: 'RCF', address: '',
            cep: '12500-000', city: 'Rio', area: 100000,
            description: 'alguma')

        expect(warehouse.valid?).to eq false
    end

    it 'quando cep é vazio' do
        warehouse =Warehouse.new(name: 'Recife', code: 'RCF', address: 'Endereço',
            cep: '', city: 'Rio', area: 100000,
            description: 'alguma')

        expect(warehouse.valid?).to eq false
    end

    it 'quando cidade é vazio' do
        warehouse =Warehouse.new(name: 'Recife', code: 'RCF', address: 'Endereço',
            cep: '12500-000', city: '', area: 100000,
            description: 'alguma')

        expect(warehouse.valid?).to eq false
    end

    it 'quando area é vazio' do
        warehouse =Warehouse.new(name: 'Recife', code: 'RCF', address: 'Endereço',
            cep: '12500-000', city: 'Rio', area: '',
            description: 'alguma')

        expect(warehouse.valid?).to eq false
    end

    it 'quando descrição é vazio' do
        warehouse =Warehouse.new(name: 'Recife', code: 'RCF', address: 'Endereço',
            cep: '12500-000', city: 'Rio', area: 100000,
            description: '')

        expect(warehouse.valid?).to eq false
    end

    it 'quando o codigo ja existe' do
    first_warehouse =Warehouse.create(name: 'Rio', code: 'RIO', address: 'Endereço',
        cep: '12500-000', city: 'Rio', area: 100000,
        description: 'alguma')
    second_warehouse =Warehouse.new(name: 'London', code: 'RIO', address: 'Av. Street',
        cep: '40500-000', city: 'London', area: 200000,
        description: 'paralelepipedo')

    expect(second_warehouse.valid?).to eq false
    end

    it 'quando o cep nao é valido' do
        warehouse =Warehouse.new(name: 'London', code: 'RIO', address: 'Av. Street',
            cep: '400-000', city: 'London', area: 200000,
            description: 'paralelepipedo')
    
        expect(warehouse.valid?).to eq false
    end
  end
end
