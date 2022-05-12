require 'rails_helper'

describe 'Usuario tenta editar um fornecedor' do
    it 'e vê campos preenchidos' do
        supplier = Supplier.create!(fantasy_name: 'CiberTech', company_name: 'CT Technology', cnpj: '9663123000109', address: 'Rua vírginio campos, 123',
            email: 'cibertech@company.com.br', phone: '81 981316988')

        product_model = ProductModel.create!(name: 'Monitor 8k', wight: 2000, width: 90, height: 30, depth: 2, sku: 'MT8000-KOREJVNERTYUO', supplier: supplier)

        visit root_path
        click_on 'Modelos de produtos'
        click_on 'Monitor 8k'
        click_on 'Editar'

        expect(page).to have_content('Editar Modelo')
        expect(page).to have_field('Produto', with: 'Monitor 8k')
        expect(page).to have_field('SKU', with: 'MT8000-KOREJVNERTYUO')
        expect(page).to have_select('Fornecedor', selected: 'CiberTech')
        expect(page).to have_field('Peso', with: '2000')
        expect(page).to have_field('Largura', with: '90')
        expect(page).to have_field('Altura', with: '30')
        expect(page).to have_field('Profundidade', with: '2')

    end

    it 'com sucesso' do
        supplier = Supplier.create!(fantasy_name: 'CiberTech', company_name: 'CT Technology', cnpj: '9663123000109', address: 'Rua vírginio campos, 123',
                        email: 'cibertech@company.com.br', phone: '81 981316988')
        product_model = ProductModel.create!(name: 'Monitor 8k', wight: 2000, width: 90, height: 30, depth: 2, sku: 'MT8000-KOREJVNERTYUO', supplier: supplier)
        
        visit root_path
        click_on 'Modelos de produto'
        click_on 'Monitor 8k'
        click_on 'Editar'

        select 'CiberTech', from: 'Fornecedor'
        fill_in 'Produto', with: 'Monitor 6k'
        fill_in 'SKU', with: 'MT8000-KOREJVNERTYUO'        
        fill_in 'Peso', with: '2000'
        fill_in 'Altura', with: '30'
        fill_in 'Largura', with: '90'
        fill_in 'Profundidade', with: '2'
        click_on 'Enviar'

        expect(current_path).to eq product_model_path(1)
        expect(page).to have_content 'Monitor 6k'
        expect(page).to have_content 'Código SKU: MT8000-KOREJVNERTYUO'
        expect(page).to have_content 'Fornecedor: CiberTech'
        expect(page).to have_content 'Peso: 2000 gramas'
        expect(page).to have_content 'Dimensões: 90cm x 30cm x 2cm'
        expect(page).to have_content 'Modelo de produto atualizado com sucesso'
    end

    it 'com campos em branco' do
        supplier = Supplier.create!(fantasy_name: 'CiberTech', company_name: 'CT Technology', cnpj: '9663123000109', address: 'Rua vírginio campos, 123',
                        email: 'cibertech@company.com.br', phone: '81 981316988')

        product_model = ProductModel.create!(name: 'Monitor 8k', wight: 2000, width: 90, height: 30, depth: 2, sku: 'MT8000-KOREJVNERTYUO', supplier: supplier)

        visit root_path
        click_on 'Modelos de produtos'
        click_on 'Monitor 8k'
        click_on 'Editar'

        select 'CiberTech', from: 'Fornecedor'
        fill_in 'Produto', with: ''
        fill_in 'SKU', with: ''
        fill_in 'Peso', with: ''
        fill_in 'Largura', with: '80'
        fill_in 'Altura', with: '45'
        fill_in 'Profundidade', with: '3'
        click_on 'Enviar'

        expect(page).to have_content 'Falha ao atualizar, preencha os dados corretamente'
    end
end