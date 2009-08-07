class AddStartedAtToPage < ActiveRecord::Migration
  def self.up
    add_column :pages, :started_at, :datetime
  end

  def self.down
    remove_column :pages, :started_at
  end
end
