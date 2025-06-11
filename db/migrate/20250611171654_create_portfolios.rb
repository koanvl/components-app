class CreatePortfolios < ActiveRecord::Migration[7.2]
  def change
    create_table :portfolios do |t|
      t.references :user, null: false, foreign_key: true
      t.string :title
      t.text :description
      t.string :project_url
      t.text :technologies

      t.timestamps
    end
  end
end
