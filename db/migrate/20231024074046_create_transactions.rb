class CreateTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :transactions do |t|
      t.string :name
      t.decimal :amount
      t.integer :author_id
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
