class CreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments do |t|
      t.text :text
      t.integer :user_id
      t.column :commentable_id, :integer
      t.column :commentable_type, :string
      t.timestamps
    end
  end

  def self.down
    drop_table :comments
  end
end
