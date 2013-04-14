class CreateTags < ActiveRecord::Migration

  def change
    create_table :conductor_tags do |t|
      t.string :name
      t.timestamps
    end

    add_index :conductor_tags, :id
    add_index :conductor_tags, :name
  end
  
end
