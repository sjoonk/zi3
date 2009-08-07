class CreateNotes < ActiveRecord::Migration
  def self.up
    create_table :notes do |t|
      t.text :body
      t.integer :user_id
      t.integer :comments_count, :default => 0

      t.timestamps
    end
    add_column :users, :notes_count, :integer, :default => 0
    add_column :boards, :notes_count, :integer, :default => 0
  end

  def self.down
    drop_table :notes
    remove_column :users, :notes_count
    remove_column :boards, :notes_count
  end
end
