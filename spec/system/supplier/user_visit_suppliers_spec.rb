require "rails_helper"

describe 'Usuario clica em fornecedores' do
    
    it 'no menu a partir da tela incial' do
        
        visit root_path
        within 'nav' do
            click_on 'Fornecedores'
        end

        expect(current_path).to eq suppliers_path
    end

    it 'e vê alguns galpões' do
        Supplier.create!(fantasy_name: 'CiberTech', company_name: 'CT Technology', cnpj: '96631230001091', address: 'Rua vírginio campos, 123',
                         email: 'cibertech@company.com.br', phone: '81 981316988')
        Supplier.create!(fantasy_name: 'CIA Tech', company_name: 'Compania e Technologia', cnpj: '96634560001091', address: 'Rua oscar raposo, 523',
                         email: 'ciatech@company.com.br', phone: '81 997661256')

        visit root_path
        click_on 'Fornecedores'

        expect(page).to have_content 'CiberTech'
        expect(page).to have_content 'CNPJ: 9663123000109'
        expect(page).to have_content 'Email: cibertech@company.com.br'

        expect(page).to have_content 'CIA Tech'
        expect(page).to have_content 'CNPJ: 9663456000109'
        expect(page).to have_content 'Email: ciatech@company.com.br'
    end

    it 'e nao tem nada cadastrado' do

        visit root_path
        click_on 'Fornecedores'

        expect(page).to have_content 'Não existem fornecedores cadastrados'
        
    end
end