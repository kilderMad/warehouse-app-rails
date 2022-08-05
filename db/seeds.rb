require 'faker'

5.times {
  name = Faker::Address.unique.city
  code = Faker::Address.unique.country_code_long
  area = Faker::Number.number(digits: 5)
  address = Faker::Address.street_address

  Warehouse.create!(name: name, code: code, city: name, area: area, address: address, cep: '50000-000',
                    description: 'Galpao altamente tecnológico e com melhor gerenciamento de distribuição')
}

9.times {
  cnpj = Faker::Company.unique.brazilian_company_number
  name = Faker::Commerce.unique.brand
  address = Faker::Address.full_address
  email = Faker::Internet.free_email(name: name)
  phone = Faker::PhoneNumber.subscriber_number(length: 11)

  Supplier.create!(fantasy_name: name, company_name: "#{name} Company", cnpj: cnpj, address: address,
                   email: email, phone: phone)
}


