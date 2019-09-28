class AddGenresToCards < ActiveRecord::Migration[5.0]
  def change
    add_column :cards, :genres, :integer
  end
end
