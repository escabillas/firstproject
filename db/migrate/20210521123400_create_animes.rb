class CreateAnimes < ActiveRecord::Migration[6.1]
  def change
    create_table :animes do |t|
      t.string :title
      t.string :animestatus
      t.integer :season
      t.string :episode

      t.timestamps
    end
  end
end
