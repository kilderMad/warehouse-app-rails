require 'rails_helper'

describe 'Usuario tenta editar um fornecedor' do
    it 'e vê campos preenchidos' do
        Supplier.create!(fantasy_name: 'CiberTech', company_name: 'CT Technology', cnpj: '96163123000109', address: 'Rua vírginio campos, 123',
                        email: 'cibertech@company.com.br', phone: '81 981316988')

        visit root_path
        click_on 'Fornecedores'
        click_on 'CiberTech'
        click_on 'Editar'

        expect(page).to have_content('Editar Fornecedor')
        expect(page).to have_field('Nome', with: 'CiberTech')
        expect(page).to have_field('Razão Social', with: 'CT Technology')
        expect(page).to have_field('CNPJ', with: '96163123000109')
        expect(page).to have_field('Endereço', with: 'Rua vírginio campos, 123')
        expect(page).to have_field('Email', with: 'cibertech@company.com.br')
        expect(page).to have_field('Telephone', with: '81 981316988')

    end

    it 'com sucesso' do
        Supplier.create!(fantasy_name: 'CiberTech', company_name: 'CT Technology', cnpj: '96631213000109', address: 'Rua vírginio campos, 123',
                        email: 'cibertech@company.com.br', phone: '81 981316988')

        visit root_path
        click_on 'Fornecedores'
        click_on 'CiberTech'
        click_on 'Editar'

        fill_in 'Nome', with: 'CiberTech21'
        fill_in 'Razão Social', with: 'CTH Technology'
        fill_in 'CNPJ', with: '12345678901231'
        fill_in 'Email', with: 'cibertech21@company.com.br'
        fill_in 'Telephone', with: '81 999766437'
        fill_in 'Endereço', with: 'Av Beira Rio, 200'
        click_on 'Enviar'

        expect(current_path).to eq supplier_path(1)
        expect(page).to have_content 'CiberTech21'
        expect(page).to have_content 'CTH Technology'
        expect(page).to have_content '12345678901231'
        expect(page).to have_content 'cibertech21@company.com.br'
        expect(page).to have_content '81 999766437'
        expect(page).to have_content 'Av Beira Rio, 200'
    end

    it 'com campos em branco' do
        Supplier.create!(fantasy_name: 'CiberTech', company_name: 'CT Technology', cnpj: '96631213000109', address: 'Rua vírginio campos, 123',
                        email: 'cibertech@company.com.br', phone: '81 981316988')

        visit root_path
        click_on 'Fornecedores'
        click_on 'CiberTech'
        click_on 'Editar'

        fill_in 'Nome', with: ''
        fill_in 'Razão Social', with: ''
        fill_in 'CNPJ', with: ''
        fill_in 'Email', with: 'cibertech21@company.com.br'
        fill_in 'Telephone', with: '81 999766437'
        fill_in 'Endereço', with: 'Av Beira Rio, 200'
        click_on 'Enviar'

        expect(page).to have_content 'Falha ao editar'
    end
end