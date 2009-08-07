class CreateBoards < ActiveRecord::Migration
  def self.up
    create_table :boards do |t|
      t.string :title
      t.string :name
      t.string :description
      t.integer :posts_count, :default => 0

      t.timestamps
    end
    add_column :posts, :board_id, :integer
  end

  def self.down
    drop_table :boards
    remove_column :posts, :board_id
  end
end
