class CreateGithubs < ActiveRecord::Migration
  def change
    create_table :githubs do |t|
      t.string :name
      t.integer :watchers
      t.integer :forks
      t.string :development_activity
      t.date :last_commit
      t.date :first_commit
      t.integer :contributors
      t.integer :issues
      t.integer :pull_requests
      t.references :package, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
