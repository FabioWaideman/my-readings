class CreateBooks < ActiveRecord::Migration[7.0]
  def change
    create_table :books do |t|
      t.string :title
      t.string :subtitle
      t.string :author
      t.string :image_url
      t.string :description
      t.string :categories
      t.float :average_rating
      t.integer :page_count
      t.date :published_date

      t.timestamps
    end
  end
end
