class CreateAssets < ActiveRecord::Migration
  def self.up
    create_table :assets do |t|
      # for attachment_fu
      t.column :size,         :integer  # file size in bytes
      t.column :content_type, :string   # mime type, ex: application/mp3
      t.column :filename,     :string   # sanitized filename
      t.column :height,       :integer  # in pixels
      t.column :width,        :integer  # in pixels
      t.column :parent_id,    :integer  # id of parent image (on the same table, a self-referencing foreign-key).
                              # Only populated if the current object is a thumbnail.
      t.column :thumbnail,    :string   # the 'type' of thumbnail this attachment record describes.  

      # general infos
      t.column :board_id, :integer
      t.column :title, :string
      t.column :comments_count, :integer, :default => 0
      
      t.timestamps
    end
    add_column :boards, :assets_count, :integer, :default => 0
    add_column :boards, :type, :string, :default => 'Board' # for STI
  end

  def self.down
    drop_table :assets
    remove_column :boards, :assets_count
    remove_column :boards, :type
  end
end
