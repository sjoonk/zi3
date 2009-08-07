class AddNameAndBloggingToPage < ActiveRecord::Migration
  def self.up
    add_column :pages, :name, :string
    add_column :pages, :blogging, :boolean, :default => false
  end

  def self.down
    remove_column :pages, :name
    remove_column :pages, :blogging
  end
end
