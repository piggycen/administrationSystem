class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
    	t.string :no
    	t.string :pwd
    	t.string :role

    	
      t.timestamps
    end
    add_index(:users, :no)
  end
end
