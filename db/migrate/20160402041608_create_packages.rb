class CreatePackages < ActiveRecord::Migration
  def change
    create_table :packages do |t|
      t.string :name
      t.text :description
      t.string :pypi_url
      t.string :documentation_url
      t.string :source_code_url
      t.string :bug_tracker_url
      t.references :category, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
