class Supplier < ApplicationRecord
  has_many :product_models

  validates :fantasy_name, :company_name, :cnpj, :email, presence: true 
  validates :cnpj, uniqueness: true
  validates :cnpj, length: { is: 14 }
end
