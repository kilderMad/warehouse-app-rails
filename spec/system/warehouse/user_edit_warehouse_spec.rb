require 'rails_helper'

describe 'Usuario edita um galpão' do
    it 'a partir da pagina de detalhes' do
        @warehouse = Warehouse.create!(name: 'Recife PE', code: 'RCF', city: 'Recife', area: 90_000,
                                        address: 'Avenida Brasil, 999', cep: '50340-000',
                                        description: 'Galpao altamente tecnológico e com melhor gerenciamento de distribuição')

        visit root_path
        click_on 'Recife PE'
        click_on 'Editar'

        expect(page).to have_content('Editar Galpão')
        expect(page).to have_field('Nome', with: 'Recife PE')
        expect(page).to have_field('Descrição', with: 'Galpao altamente tecnológico e com melhor gerenciamento de distribuição')
        expect(page).to have_field('Código', with: 'RCF')
        expect(page).to have_field('Endereço', with: 'Avenida Brasil, 999')
        expect(page).to have_field('Cidade', with: 'Recife')
        expect(page).to have_field('CEP', with: '50340-000')
        expect(page).to have_field('Área', with: '90000')
    end

    it 'com sucesso' do
        @warehouse = Warehouse.create!(name: 'Recife PE', code: 'RCF', city: 'Recife', area: 90_000,
            address: 'Avenida Brasil, 999', cep: '50340-000',
            description: 'Galpao altamente tecnológico e com melhor gerenciamento de distribuição')

        visit root_path
        click_on 'Recife PE'
        click_on 'Editar'

        fill_in 'Nome', with: 'Tamarineira'
        fill_in 'Código', with: 'TMR'
        fill_in 'Cidade', with: 'Recife' 
        fill_in 'Área', with: '90000' 
        fill_in 'Endereço', with: 'Av. Monolito, 134' 
        fill_in 'CEP', with: '50340-000' 
        fill_in 'Descrição', with: 'Top top' 
        click_on 'Enviar'

        expect(current_path).to eq warehouse_path(@warehouse.id)
        expect(page).to have_content 'Tamarineira TMR'
        expect(page).to have_content "Cidade:\nRecife"
        expect(page).to have_content "Área:\n90000"
        expect(page).to have_content "Endereço:\nAv. Monolito, 134, CEP: 50340-000"
        expect(page).to have_content 'Top top'
        expect(page).to have_content 'Galpão atualizado com sucesso!'
    end

    it 'e mantem os campos obrigatorios' do
        @warehouse = Warehouse.create!(name: 'Recife FPE', code: 'RFF', city: 'Recife', area: 90_000,
            address: 'Avenida Brasil, 999', cep: '50340-000',
            description: 'Galpao altamente tecnológico e com melhor gerenciamento de distribuição')

        visit root_path
        click_on 'Recife FPE'
        click_on 'Editar'

        fill_in 'Nome', with: 'Tamarineira'
        fill_in 'Código', with: ''
        fill_in 'Cidade', with: '' 
        fill_in 'Área', with: '' 
        fill_in 'Endereço', with: 'Av. Monolito, 134' 
        fill_in 'CEP', with: '50340-000' 
        fill_in 'Descrição', with: 'Top top' 
        click_on 'Enviar'

        expect(page).to have_content 'Galpão não atualizado'
    end
end