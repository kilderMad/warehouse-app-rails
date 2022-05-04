require 'rails_helper'

describe 'Usuario cadastra um galpão' do 
    it 'indo da tela inicial' do
        visit root_path
        click_on 'Cadastrar Galpão'

        expect(page).to have_field('Nome')
        expect(page).to have_field('Descrição')
        expect(page).to have_field('Código')
        expect(page).to have_field('Endereço')
        expect(page).to have_field('Cidade')
        expect(page).to have_field('CEP')
        expect(page).to have_field('Área')
    end

    it 'com sucesso' do
        visit root_path
        click_on 'Cadastrar Galpão'

        fill_in 'Nome', with: 'Recife Galpões'
        fill_in 'Descrição', with: 'Galpoẽs altamente tecnolicos com alto sistema de gerenciamento de cargas'
        fill_in 'Código', with: 'RCF'
        fill_in 'Endereço', with: 'Avenida Brasil, 999'
        fill_in 'Cidade', with: 'Recife'
        fill_in 'CEP', with: '50670-234'
        fill_in 'Áre', with: '90000'
        click_on 'Enviar'

        expect(current_path).to eq root_path
        expect(page).to have_content 'Recife Galpões'
        expect(page).to have_content 'Código: RCF'
        expect(page).to have_content 'Cidade: Recife'
        expect(page).to have_content '90000'

    end
end