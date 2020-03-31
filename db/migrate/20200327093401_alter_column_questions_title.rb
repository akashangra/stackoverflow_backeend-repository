class AlterColumnQuestionsTitle < ActiveRecord::Migration[5.1]
  def change
    change_table :questions do |t|
      add_index :questions, :title, unique: true
    end
  end
end
