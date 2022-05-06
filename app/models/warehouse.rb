class Warehouse < ApplicationRecord
    validates :name, :description, :cep, :area, :city, :address, presence: true
    validates :code, length: { is: 3 }
end
