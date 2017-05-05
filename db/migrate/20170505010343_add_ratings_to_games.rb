class AddRatingsToGames < ActiveRecord::Migration[5.1]
  def change
    add_column :games, :rating, :string
  end
end
