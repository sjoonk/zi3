class RenamePostToPageForSti < ActiveRecord::Migration
  def self.up
    rename_table  :posts, :pages
    add_column :pages, :type, :string
  end

  def self.down
    remove_column :pages, :type
    rename_table :pages, :posts
  end
end
