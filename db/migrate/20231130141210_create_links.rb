class CreateLinks < ActiveRecord::Migration[7.1]
  def change
    create_table :links do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name
      t.string :url
      t.string :slug
      t.string :link_type
      t.datetime :expires_at
      t.string :password
      t.string :short_url

      t.timestamps
    end
  end
end
