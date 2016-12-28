class AddSlugToWiki < ActiveRecord::Migration[5.0]
  def change
    add_column :wikis, :slug, :string
    add_index :wikis, :slug, unique: true
  end
end
