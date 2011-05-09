class AddPrivilegesToMemberships < ActiveRecord::Migration
  def self.up
  	add_column :memberships, :pool,   :boolean
  	add_column :memberships, :sauna,  :boolean
  	add_column :memberships, :tennis, :boolean
  	add_column :memberships, :guests, :integer
  end

  def self.down
  	remove_column :memberships, :pool
  	remove_column :memberships, :sauna
  	remove_column :memberships, :tennis
  	remove_column :memberships, :guests
  end
end
