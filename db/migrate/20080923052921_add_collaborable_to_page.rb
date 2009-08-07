class AddCollaborableToPage < ActiveRecord::Migration
  def self.up
    add_column :pages, :collaborable, :boolean, :default => false
  end

  def self.down
    remove_column :pages, :collaborable
  end
end
