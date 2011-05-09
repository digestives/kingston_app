class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :organisation
      t.string :forename
      t.string :surname
      t.text :address
      t.string :post_code
      t.string :telephone
      t.string :email
      t.string :encrypted_password
      t.string :salt

      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
