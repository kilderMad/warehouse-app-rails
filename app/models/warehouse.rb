class Warehouse < ApplicationRecord
    validates :name, :description, :cep, :area, :city, :address, presence: true
    validates :code, length: { is: 3 }, uniqueness: true
    validates :cep, format: { with: /\d{5}-?\d{3}/ }
    validates :name, uniqueness: true 
    
    has_many :stock_products

    def full_description
        "#{code} - #{name}"
    end
end

