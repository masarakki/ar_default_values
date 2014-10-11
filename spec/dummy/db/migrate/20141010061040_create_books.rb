class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :title
      t.integer :edition
      t.integer :price
      t.datetime :released_at
      t.timestamps
    end
  end
end
