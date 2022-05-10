class Supplier < ApplicationRecord
    validates :fantasy_name, :company_name, :cnpj, :email, presence: true 
    validates :cnpj, uniqueness: true
    validates :cnpj, length: { is: 13 }
end
