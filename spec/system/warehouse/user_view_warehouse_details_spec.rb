require 'rails_helper'

describe 'Usuario clica no galpao' do
    it 'e vê detalhes do galpão' do
        @warehouse = Warehouse.create(name: 'Recife PE', code: 'RCF', city: 'Recife', area: 90_000,
            address: 'Avenida Brasil, 999', cep: '50340-000',
            description: 'Galpao altamente tecnológico e com melhor gerenciamento de distribuição')

        visit root_path

        click_on 'Recife PE'

        expect(current_path).to eq warehouse_path(@warehouse.id)
        expect(page).to have_content('Recife PE RCF')
        expect(page).to have_content("Cidade:\nRecife")
        expect(page).to have_content("Área:\n90000")
        expect(page).to have_content('Galpao altamente tecnológico e com melhor gerenciamento de distribuição')
        expect(page).to have_content("Endereço:\nAvenida Brasil, 999, CEP: 50340-000")      
    end

    it 'e clica em voltar pra tela inicial' do
        Warehouse.create(name: 'Recife PE', code: 'RCF', city: 'Recife', area: 90_000,
            address: 'Avenida Brasil, 999', cep: '50340-000',
            description: 'Galpao altamente tecnológico e com melhor gerenciamento de distribuição')

        visit root_path

        click_on 'Recife PE'
        click_on 'Voltar'

        expect(current_path).to eq root_path
    end
    
end