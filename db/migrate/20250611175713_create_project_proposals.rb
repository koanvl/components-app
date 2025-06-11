class CreateProjectProposals < ActiveRecord::Migration[7.2]
  def change
    create_table :project_proposals do |t|
      t.references :project, null: false, foreign_key: true
      t.references :freelancer, null: false, foreign_key: true
      t.text :proposal_text
      t.decimal :budget
      t.integer :timeline
      t.integer :status

      t.timestamps
    end
  end
end
