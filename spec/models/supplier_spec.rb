require 'rails_helper'

RSpec.describe Supplier, type: :model do
    describe '#valid?' do
        it 'quando nome é vazio' do
            supplier = Supplier.new(fantasy_name: '', company_name: 'CT Technology', cnpj: '9663123000109', address: 'Rua vírginio campos, 123',
                email: 'cibertech@company.com.br', phone: '81 981316988')

            expect(supplier.valid?).to eq false
        end

        it 'quando razao social é vazio' do
            supplier = Supplier.new(fantasy_name: 'CiberTech', company_name: '', cnpj: '9663123000109', address: 'Rua vírginio campos, 123',
                email: 'cibertech@company.com.br', phone: '81 981316988')

            expect(supplier.valid?).to eq false
        end

        it 'quando CNPJ é vazio' do
            supplier = Supplier.new(fantasy_name: 'CiberTech', company_name: 'CT Technology', cnpj: '', address: 'Rua vírginio campos, 123',
                email: 'cibertech@company.com.br', phone: '81 981316988')

            expect(supplier.valid?).to eq false
        end

        it 'quando email é vazio' do
            supplier = Supplier.new(fantasy_name: 'CiberTech', company_name: 'CT Technology', cnpj: '9663123000109', address: 'Rua vírginio campos, 123',
                email: '', phone: '81 981316988')

            expect(supplier.valid?).to eq false
        end

        it 'quando CNPJ nao possui 13 digitos' do
            supplier = Supplier.new(fantasy_name: 'CiberTech', company_name: 'CT Technology', cnpj: '966312000109', address: 'Rua vírginio campos, 123',
                email: 'cibertech@company.com.br', phone: '81 981316988')

            expect(supplier.valid?).to eq false
        end

        it 'quando CNPJ ja existe' do
            f_supplier = Supplier.create!(fantasy_name: 'CiberTech', company_name: 'CT Technology', cnpj: '96631200010951', address: 'Rua vírginio campos, 123',
                email: 'cibertech@company.com.br', phone: '81 981316988')
            s_supplier = Supplier.new(fantasy_name: 'ChTech', company_name: 'CHGF Technology', cnpj: '96631200010951', address: 'Rua hongro fibonato, 567',
                email: 'gthj@company.com.br', phone: '81 666316988')

            expect(s_supplier.valid?).to eq false
        end
    end
end
