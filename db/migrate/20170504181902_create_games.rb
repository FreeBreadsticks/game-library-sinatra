class CreateGames < ActiveRecord::Migration[4.2]
  def change
    create_table :games do |t|
      t.string :title
      t.string :notes
      t.integer :user_id
    end
  end
end
