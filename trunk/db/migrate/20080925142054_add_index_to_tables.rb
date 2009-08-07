class AddIndexToTables < ActiveRecord::Migration
  def self.up
    # set limits for index key
    change_column :pages, :type, :string, :limit => 20
    change_column :assets, :type, :string, :limit => 20
    change_column :boards, :name, :string, :limit => 20
    change_column :comments, :commentable_type, :string, :limit => 20
    change_column :roles, :name, :string, :limit => 10
    change_column :versions, :versionable_type, :string, :limit => 20
    change_column :users, :login, :string, :limit => 20

    add_index :users, :updated_at
    add_index :pages, :created_at
    add_index :pages, :updated_at
    add_index :pages, :blogging
    add_index :pages, :type
    add_index :roles, :name, :unique => true
    add_index :assets, [:parent_id, :type]
    add_index :assets, [:board_id, :type]
    add_index :notes, :created_at
    add_index :boards, :name, :unique => true
    add_index :boards, :type
    add_index :boards, :updated_at
    add_index :comments, [:commentable_id, :commentable_type]
    add_index :titles, :text
    add_index :pages_titles, :page_id
    add_index :pages_titles, :title_id
    
  end

  def self.down
  end
end
