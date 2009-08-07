class AddTypeToAsset < ActiveRecord::Migration
  def self.up
    add_column :assets, :type, :string, :default => 'Asset'
  end

  def self.down
    remove_column :assets, :type
  end
end
