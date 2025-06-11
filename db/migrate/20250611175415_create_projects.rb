class CreateProjects < ActiveRecord::Migration[7.2]
  def change
    create_table :projects do |t|
      t.string :title
      t.text :description
      t.decimal :budget_min
      t.decimal :budget_max
      t.date :deadline
      t.integer :status
      t.references :client, null: false, foreign_key: true
      t.string :category
      t.text :skills

      t.timestamps
    end
  end
end
