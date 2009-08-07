class CreateTitles < ActiveRecord::Migration
  def self.up
    create_table :titles do |t|
      t.string :text

      t.timestamps
    end
    create_table :pages_titles, :id => false do |t|
      t.integer :page_id, :title_id
    end
  end

  def self.down
    drop_table :titles
    drop_table :pages_titles
  end
end
