class CreateAnswers < ActiveRecord::Migration[5.1]
  def change
    create_table :answers do |t|
      t.string :title
      t.text :description
      t.references :user, foreign_key: true,index: true
      t.references :question, foreign_key: true,index: true

      t.timestamps
    end
  end
end
