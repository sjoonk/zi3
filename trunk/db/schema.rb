# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20081008091123) do

  create_table "assets", :force => true do |t|
    t.integer  "size",           :limit => 11
    t.string   "content_type"
    t.string   "filename"
    t.integer  "height",         :limit => 11
    t.integer  "width",          :limit => 11
    t.integer  "parent_id",      :limit => 11
    t.string   "thumbnail"
    t.integer  "board_id",       :limit => 11
    t.string   "title"
    t.integer  "comments_count", :limit => 11, :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "page_id",        :limit => 11
    t.string   "type",           :limit => 20, :default => "Asset"
  end

  add_index "assets", ["parent_id", "type"], :name => "index_assets_on_parent_id_and_type"
  add_index "assets", ["board_id", "type"], :name => "index_assets_on_board_id_and_type"
  add_index "assets", ["type"], :name => "index_assets_on_type"

  create_table "boards", :force => true do |t|
    t.string   "title"
    t.string   "name",         :limit => 20
    t.string   "description"
    t.integer  "posts_count",  :limit => 11, :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "notes_count",  :limit => 11, :default => 0
    t.integer  "assets_count", :limit => 11, :default => 0
    t.string   "type",         :limit => 20, :default => "Board"
    t.integer  "user_id",      :limit => 11
    t.boolean  "attachable",                 :default => false
    t.integer  "open_level",   :limit => 11, :default => 999
  end

  add_index "boards", ["name"], :name => "index_boards_on_name", :unique => true
  add_index "boards", ["type"], :name => "index_boards_on_type"
  add_index "boards", ["updated_at"], :name => "index_boards_on_updated_at"
  add_index "boards", ["id", "type"], :name => "index_boards_on_id_and_type"

  create_table "comments", :force => true do |t|
    t.text     "text"
    t.integer  "user_id",          :limit => 11
    t.integer  "commentable_id",   :limit => 11
    t.string   "commentable_type", :limit => 20
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "parent_id",        :limit => 11
    t.integer  "lft",              :limit => 11
    t.integer  "rgt",              :limit => 11
  end

  add_index "comments", ["commentable_id", "commentable_type"], :name => "index_comments_on_commentable_id_and_commentable_type"
  add_index "comments", ["commentable_id"], :name => "index_comments_on_commentable_id"
  add_index "comments", ["commentable_id", "parent_id"], :name => "index_comments_on_commentable_id_and_parent_id"
  add_index "comments", ["lft"], :name => "index_comments_on_lft"

  create_table "notes", :force => true do |t|
    t.text     "body"
    t.integer  "user_id",        :limit => 11
    t.integer  "comments_count", :limit => 11, :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "board_id",       :limit => 11
  end

  add_index "notes", ["created_at"], :name => "index_notes_on_created_at"

  create_table "pages", :force => true do |t|
    t.string   "title"
    t.text     "body"
    t.integer  "user_id",        :limit => 11
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "board_id",       :limit => 11
    t.integer  "parent_id",      :limit => 11
    t.integer  "replies_count",  :limit => 11, :default => 0
    t.integer  "views",          :limit => 11, :default => 0
    t.string   "type",           :limit => 20
    t.string   "name"
    t.boolean  "blogging",                     :default => false
    t.integer  "assets_count",   :limit => 11, :default => 0
    t.integer  "comments_count", :limit => 11, :default => 0
    t.boolean  "collaborable",                 :default => false
    t.datetime "started_at"
    t.string   "visitor"
  end

  add_index "pages", ["created_at"], :name => "index_pages_on_created_at"
  add_index "pages", ["blogging"], :name => "index_pages_on_blogging"
  add_index "pages", ["type"], :name => "index_pages_on_type"
  add_index "pages", ["updated_at"], :name => "index_pages_on_updated_at"

  create_table "pages_titles", :id => false, :force => true do |t|
    t.integer "page_id",  :limit => 11
    t.integer "title_id", :limit => 11
  end

  add_index "pages_titles", ["page_id"], :name => "index_pages_titles_on_page_id"
  add_index "pages_titles", ["title_id"], :name => "index_pages_titles_on_title_id"

  create_table "passwords", :force => true do |t|
    t.integer  "user_id",         :limit => 11
    t.string   "reset_code"
    t.datetime "expiration_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles", :force => true do |t|
    t.string "name", :limit => 10
  end

  add_index "roles", ["name"], :name => "index_roles_on_name", :unique => true

  create_table "roles_users", :id => false, :force => true do |t|
    t.integer "role_id", :limit => 11
    t.integer "user_id", :limit => 11
  end

  add_index "roles_users", ["user_id"], :name => "index_roles_users_on_user_id"
  add_index "roles_users", ["role_id"], :name => "index_roles_users_on_role_id"

  create_table "titles", :force => true do |t|
    t.string   "text"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "titles", ["text"], :name => "index_titles_on_text"

  create_table "users", :force => true do |t|
    t.string   "login",                     :limit => 20
    t.string   "name",                      :limit => 100, :default => ""
    t.string   "email",                     :limit => 100
    t.string   "crypted_password",          :limit => 40
    t.string   "salt",                      :limit => 40
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token",            :limit => 40
    t.datetime "remember_token_expires_at"
    t.string   "activation_code",           :limit => 40
    t.datetime "activated_at"
    t.string   "state",                                    :default => "passive"
    t.datetime "deleted_at"
    t.datetime "last_login_at"
    t.integer  "notes_count",               :limit => 11,  :default => 0
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size",          :limit => 11
    t.datetime "avatar_updated_at"
    t.string   "nickname"
    t.string   "homepage"
    t.string   "messenger"
    t.string   "phone"
    t.text     "memo"
  end

  add_index "users", ["login"], :name => "index_users_on_login", :unique => true
  add_index "users", ["updated_at"], :name => "index_users_on_updated_at"

  create_table "versions", :force => true do |t|
    t.integer  "versionable_id",   :limit => 11
    t.string   "versionable_type", :limit => 20
    t.integer  "number",           :limit => 11
    t.text     "yaml"
    t.datetime "created_at"
  end

  add_index "versions", ["versionable_id", "versionable_type"], :name => "index_versions_on_versionable_id_and_versionable_type"

  create_table "viewings", :force => true do |t|
    t.integer  "viewer_id",   :limit => 11
    t.integer  "viewed_id",   :limit => 11
    t.string   "viewed_type"
    t.string   "ip",          :limit => 24
    t.datetime "created_at"
  end

  add_index "viewings", ["viewed_type", "viewed_id"], :name => "index_viewings_on_viewed_type_and_viewed_id"
  add_index "viewings", ["viewer_id"], :name => "index_viewings_on_viewer_id"

end
