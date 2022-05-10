require 'rails_helper'

describe 'Usuario cadastra um fornecedor' do
    
    it 'com sucesso' do
        
        visit root_path
        click_on 'Fornecedores'
        click_on 'Cadastrar Fornecedor'

        fill_in 'Nome', with: 'Logenet'
        fill_in 'Razão Social', with: 'Logenet eletronicos'
        fill_in 'CNPJ', with: '1234567890123'
        fill_in 'Email', with: 'logenet@gmail.com'
        fill_in 'Telephone', with: '81 988766437'
        fill_in 'Endereço', with: 'Av Rui barbosa, 769'
        click_on 'Enviar'

        expect(current_path).to eq supplier_path(1)
        expect(page).to have_content 'Logenet'
        expect(page).to have_content 'CNPJ: 1234567890123'
        expect(page).to have_content 'Email: logenet@gmail.com'
        expect(page).to have_content 'Fornecedor cadastrado com sucesso'

    end

    it 'com campos em branco' do
        visit root_path
        click_on 'Fornecedores'
        click_on 'Cadastrar Fornecedor'

        click_on 'Enviar'

        expect(page).to have_content 'Falha ao cadastrar'

    end
end