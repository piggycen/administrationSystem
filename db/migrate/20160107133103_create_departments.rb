class CreateDepartments < ActiveRecord::Migration
  def change
    create_table :departments do |t|
    	t.string :dno
      	t.string :dname

      t.timestamps
    end
    add_index(:departments, :dno)
  end
end
