class CreateSuppliers < ActiveRecord::Migration[7.0]
  def change
    create_table :suppliers do |t|
      t.string :fantasy_name
      t.string :company_name
      t.string :cnpj
      t.string :address
      t.string :email
      t.string :phone

      t.timestamps
    end
  end
end
