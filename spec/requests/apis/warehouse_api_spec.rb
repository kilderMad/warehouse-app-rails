require 'rails_helper'

describe 'Warehouse API' do
  context 'GET /api/v1/warehouses/1' do
    it 'success' do
      warehouse = Warehouse.create!(name: 'Recife PE', code: 'RCF', city: 'Recife', area: 90_000,
                                    address: 'Avenida Brasil, 999', cep: '50340-000',
                                    description: 'Galpao altamente tecnológico e com melhor
                                                  gerenciamento de distribuição')

      get "/api/v1/warehouses/#{warehouse.id}"

      expect(response.status).to eq 200
      expect(response.content_type).to include('application/json')
      json_response = JSON.parse(response.body)
      expect(json_response['name']).to eq('Recife PE')
      expect(json_response['code']).to eq('RCF')
      expect(json_response.keys).not_to include('created_at')
      expect(json_response.keys).not_to include('updated_at')
    end

    it 'fail if warehouse not found' do
      get '/api/v1/warehouses/9999'
      expect(response.status).to eq 404
    end
  end

  context 'GET /api/v1/warehouses' do
    it 'success' do
      Warehouse.create!(name: 'Recife PE', code: 'RCF', city: 'Recife', area: 90_000,
                        address: 'Avenida Brasil, 999', cep: '50340-000',
                        description: 'Galpao altamente tecnológico e com melhor gerenciamento de distribuição')
      Warehouse.create!(name: 'São Paulo', code: 'GRU', city: 'São PAULO', area: 190_000,
                        address: 'Avenida Brasil, 999', cep: '50340-000',
                        description: 'Galpao altamente tecnológico e com melhor gerenciamento de distribuição')

      get '/api/v1/warehouses'

      expect(response.status).to eq 200
      expect(response.content_type).to include('application/json')
      json_response = JSON.parse(response.body)
      expect(json_response.length).to eq 2
      expect(json_response.first['name']).to eq 'Recife PE'
      expect(json_response.last['name']).to eq 'São Paulo'
    end

    it 'return empty if there is no warehouse' do
      get '/api/v1/warehouses'

      expect(response.status).to eq 200
      expect(response.content_type).to include('application/json')
      json_response = JSON.parse(response.body)
      expect(json_response.length).to eq 0
    end

    it 'and raise internal error' do
      allow(Warehouse).to receive(:all).and_raise(ActiveRecord::QueryAborted)

      get '/api/v1/warehouses'

      expect(response.status).to eq 500
    end
  end

  context 'POST /api/v1/warehouses' do
    it 'success' do
      warehouse_params = { warehouse: { name: 'Recife PE', code: 'RCF', city: 'Recife', area: 90_000,
                                        address: 'Avenida Brasil, 999', cep: '50340-000',
                                        description: 'Galpao tecnológico e com melhor 
                                                      gerenciamento de distribuição'}}

      post '/api/v1/warehouses', params: warehouse_params

      expect(response.status).to eq 201
      expect(response.content_type).to include 'application/json'
      json_response = JSON.parse(response.body)
      expect(json_response['name']).to eq warehouse_params[:warehouse][:name]
      expect(json_response['code']).to eq warehouse_params[:warehouse][:code]
      expect(json_response['city']).to eq warehouse_params[:warehouse][:city]
      expect(json_response['area']).to eq warehouse_params[:warehouse][:area]
      expect(json_response['address']).to eq warehouse_params[:warehouse][:address]
      expect(json_response['cep']).to eq warehouse_params[:warehouse][:cep]
      expect(json_response['description']).to eq warehouse_params[:warehouse][:description]
    end

    it 'fail if parmas are not complete' do
      warehouse_params = { warehouse: { name: 'Recife PE', code: 'RCF', city: 'Recife', area: 90_000}}

      post '/api/v1/warehouses', params: warehouse_params

      expect(response.status).to eq 412
      expect(response.body).to include 'Descrição não pode ficar em branco'
      expect(response.body).to include 'CEP não pode ficar em branco'
      expect(response.body).to include 'Endereço não pode ficar em branco'
    end

    it 'fail if theres an internal error' do
      allow(Warehouse).to receive(:new).and_raise(ActiveRecord::ActiveRecordError)
      warehouse_params = { warehouse: { name: 'Recife PE', code: 'RCF', city: 'Recife', area: 90_000,
                                        address: 'Avenida Brasil, 999', cep: '50340-000',
                                        description: 'Galpao tecnológico e com melhor
                                                      gerenciamento de distribuição'}}

      post '/api/v1/warehouses', params: warehouse_params

      expect(response.status).to eq 500
    end
  end
end
