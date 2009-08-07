class AddAttachableToBoard < ActiveRecord::Migration
  def self.up
    add_column :boards, :attachable, :boolean, :default => false
  end

  def self.down
    remove_column :boards, :attachable
  end
end
