class CreateBlogs < ActiveRecord::Migration
  def change
    create_table :blogs do |t|
      t.string :title, null: false
      t.text :body, null: false
      t.integer :click_count, default: 0
      t.integer :published, default: 0
      t.integer :status, default: 0
      t.references :user

      t.timestamps null: false
    end
  end
end
