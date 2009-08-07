class AddAssetsCountAndPageIdToPage < ActiveRecord::Migration
  def self.up
    add_column :pages, :assets_count, :integer, :default => 0
    add_column :assets, :page_id, :integer
  end

  def self.down
    remove_column :pages, :assets_count
    remove_column :assets, :page_id
  end
end
