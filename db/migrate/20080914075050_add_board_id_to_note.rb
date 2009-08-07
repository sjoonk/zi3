class AddBoardIdToNote < ActiveRecord::Migration
  def self.up
    add_column :notes, :board_id, :integer
  end

  def self.down
    remove_column :notes, :board_id
  end
end
