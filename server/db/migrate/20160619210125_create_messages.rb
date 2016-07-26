class CreateMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :messages, id: :uuid do |t|
      t.uuid :portfolio_id, null: false
      t.text :content

      t.timestamps
    end

    add_index :messages, :portfolio_id
  end
end
