require 'rails_helper'

describe 'O usuario entra na home' do
    it 'e vê Galpões e Estoque' do
        visit('/')
        
        expect(page).to have_content('Galpões e Estoque')
    end

    it 'e vê todos os galpões cadastrados' do
        Warehouse.create(name: 'Recife', code: 'RCF', city: 'Recife', area: 90_000)        
        Warehouse.create(name: 'São Paulo', code: 'GRU', city: 'Guarulhos', area: 100_000)
        
        visit('/')

        expect(page).not_to have_content('Não existem galpões cadastrados')
        expect(page).to have_content('Recife')
        expect(page).to have_content('Código: RCF')
        expect(page).to have_content('Cidade: Recife')
        expect(page).to have_content('90000')

        expect(page).to have_content('São Paulo')
        expect(page).to have_content('Código: GRU')
        expect(page).to have_content('Cidade: Guarulhos')
        expect(page).to have_content('100000')
    end

    it 'e vê mensagem de Não existem galpões cadastrados' do
        visit('/')

        expect(page).to have_content('Não existem galpões cadastrados')
    end
end