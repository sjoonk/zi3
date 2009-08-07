class AddVisitorToPage < ActiveRecord::Migration
  def self.up
    add_column :pages, :visitor, :string
  end

  def self.down
    remove_column :pages, :visitor
  end
end
