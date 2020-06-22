class CreateUrlWords < ActiveRecord::Migration[6.0]
  def change
    create_table :url_words do |t|
      t.string :word, index: true
      t.datetime :expires_at
      t.references :link, foreign_key: true

      t.timestamps
    end
  end
end
