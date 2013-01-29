class CreatePages < ActiveRecord::Migration

  def change
    create_table :conductor_pages do |t|
      t.string :title
      t.string :slug
      t.string :browser_title
      t.string :menu_title
      t.string :keywords
      t.string :description
      t.string :view_template
      t.string :layout_template
      t.string :link_url
      t.boolean :draft, :default => true
      t.boolean :deletable, :default => true
      t.boolean :skip_to_first_child, :default => false
      t.boolean :show_in_menu, :default => true
      t.integer :parent_id
      t.integer :lft
      t.integer :rgt
      t.timestamps
    end

    add_index :conductor_pages, :id
    add_index :conductor_pages, :parent_id
    add_index :conductor_pages, :slug
    add_index :conductor_pages, :lft
    add_index :conductor_pages, :rgt
  end

end
