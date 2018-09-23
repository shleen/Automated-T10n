class CreateTranslations < ActiveRecord::Migration[5.2]
  def change
    create_table :translations do |t|
      t.string :from, default: 'en'
      t.string :to, null: false
      t.string :file

      t.timestamps
    end
  end
end
