class RemoveSubtitleFromBooks < ActiveRecord::Migration[7.0]
  def change
    remove_column :books, :subtitle, :string
  end
end
