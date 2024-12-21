class CreateProducts < ActiveRecord::Migration[8.0]
  def change
    create_table :products do |t|
      t.string :name
      
      t.timestamps # defines 2 columns: `created_at:datetime` & `updated_at:datetime`
    end
  end
end
