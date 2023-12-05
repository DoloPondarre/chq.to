class CreateAccesses < ActiveRecord::Migration[7.1]
  def change
    create_table :accesses do |t|
      t.references :link, null: false, foreign_key: true
      t.string :ip_address

      t.timestamps
    end
  end
end
