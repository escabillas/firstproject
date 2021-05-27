class AddAnimestatusToAnimes < ActiveRecord::Migration[6.1]
  def change
    add_column :animes, :animestatus, :string
  end
end
