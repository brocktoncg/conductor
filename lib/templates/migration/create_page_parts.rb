class CreatePageParts < ActiveRecord::Migration

  def change
    create_table :conductor_page_parts do |t|
      t.integer :page_id
      t.integer :position
      t.string :title
      t.text :body
      t.timestamps
    end

    add_index :conductor_page_parts, :id
    add_index :conductor_page_parts, :page_id
  end
  
end
