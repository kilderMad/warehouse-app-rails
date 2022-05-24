require 'rails_helper'

describe 'usuario ve seus propios pedidos' do
  it 'e deve estar autenticado' do
    visit root_path
    click_on 'Meus Pedidos'

    expect(current_path).to eq new_admin_session_path 
  end

  it 'e nao ve outros pedidos' do
    supplier = Supplier.create!(fantasy_name: 'CiberTech', company_name: 'CT Technology', cnpj: '9663123000109', address: 'Rua vírginio campos, 123',
      email: 'cibertech@company.com.br', phone: '81 981316988')
    warehouse = Warehouse.create!(name: 'Recife', code: 'RCF', city: 'Recife', area: 90_000,
      address: 'Avenida do aeroporto, 1000', cep: '15000-000',
      description: 'Galpao destinado para cargas internacionais')
    user = Admin.create!(name: 'joao', email: 'joao@gmail.com', password:'password')
    user2 = Admin.create!(name: 'kilder', email: 'kilder@gmail.com', password:'password')
    allow(SecureRandom).to receive(:alphanumeric).and_return('SPC00001')
    order2 = Order.create!(admin: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 2.day.from_now)
    allow(SecureRandom).to receive(:alphanumeric).and_return('RCF98765')
    order3 = Order.create!(admin: user2, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 3.day.from_now)
    
    login_as(user)
    visit root_path
    click_on 'Meus Pedidos'

    expect(page).to have_content order2.code
    expect(page).not_to have_content order3.code
  end
end 