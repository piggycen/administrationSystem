class CreateTeachers < ActiveRecord::Migration
  def change
    create_table :teachers do |t|
    	t.string :tno
	    t.string :tname
	    t.string :tsex
	    t.date :tbirthday
	    t.string :tfunction
	    t.string :tplace
	    t.string :tnation
	    t.string :tpassport
	    t.belongs_to :department

      t.timestamps
    end
    add_index(:teachers, :tno)
  end
end
