class AddOpenLevelToBoard < ActiveRecord::Migration
  def self.up
    add_column :boards, :open_level, :integer, :default => 999
  end

  def self.down
    remove_column :boards, :open_level
  end
end
