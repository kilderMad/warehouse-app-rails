require 'rails_helper'

describe 'Usuario remove um galpao' do
    it 'com sucesso e nao apaga outros' do
        @first_warehouse = Warehouse.create!(name: 'Recife Galpões', code: 'RCF', city: 'Recife', area: 90_000,
            address: 'Avenida Brasil, 999', cep: '50340-000',
            description: 'Galpao altamente tecnológico e com melhor gerenciamento de distribuição')
        @second_warehouse = Warehouse.create!(name: 'Gloria Depositos', code: 'GLR', city: 'Gloria', area: 90_000,
            address: 'Avenida Joao, 99', cep: '60340-000',
            description: 'Galpao altamente tecnológico e com melhor gerenciamento de distribuição')
        
        visit root_path
        click_on 'Recife Galpões'
        click_on 'Remover'

        expect(current_path).to eq root_path
        expect(page).not_to have_content 'Recife Galpões'
        expect(page).not_to have_content 'RCF'
        expect(page).not_to have_content 'Recife'
        expect(page).to have_content 'Galpão removido com sucesso'

        expect(page).to have_content 'Gloria Depositos'
        expect(page).to have_content 'GLR'
        expect(page).to have_content 'Gloria'
    end
end