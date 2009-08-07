class AddParentIdToPost < ActiveRecord::Migration
  def self.up
    add_column :posts, :parent_id, :integer
    add_column :posts, :replies_count, :integer, :default => 0
  end

  def self.down
    remove_column :posts, :parent_id
    remove_column :posts, :replies_count
  end
end
