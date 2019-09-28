class AddRankToCards < ActiveRecord::Migration[5.0]
  def change
    add_column :cards, :rank, :integer, default: 5
  end
end
