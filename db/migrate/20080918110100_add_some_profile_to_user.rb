class AddSomeProfileToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :nickname, :string
    add_column :users, :homepage, :string
    add_column :users, :messenger, :string
    add_column :users, :phone, :string
    add_column :users, :memo, :text
  end

  def self.down
    remove_column :users, :nickname
    remove_column :users, :homepage
    remove_column :users, :messenger
    remove_column :users, :phone
    remove_column :users, :memo
  end
end
