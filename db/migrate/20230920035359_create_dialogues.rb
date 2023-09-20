class CreateDialogues < ActiveRecord::Migration[7.0]
  def change
    create_table :dialogues do |t|
      t.text :question
      t.text :answer
      t.references :session, index: true

      t.timestamps
    end
  end
end
