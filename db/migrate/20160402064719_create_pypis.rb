class CreatePypis < ActiveRecord::Migration
  def change
    create_table :pypis do |t|
      t.string :name
      t.integer :download_num
      t.integer :release_num
      t.string :current_version
      t.date :released_date
      t.date :first_release
      t.string :python_version
      t.references :package, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
