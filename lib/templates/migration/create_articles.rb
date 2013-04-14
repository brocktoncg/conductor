class CreateArticles < ActiveRecord::Migration

  def change
    create_table :conductor_articles do |t|
      t.integer :user_id
      t.string :title
      t.text :body
      t.string :slug
      t.datetime :post_at
      t.datetime :expire_at
      t.boolean :draft, :default => true
      t.boolean :featured, :default => false
      t.timestamps
    end

    add_index :conductor_articles, :id
    add_index :conductor_articles, :slug
  end

end
