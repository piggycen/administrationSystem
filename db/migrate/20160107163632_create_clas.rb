class CreateClas < ActiveRecord::Migration
  def change
    create_table :clas do |t|
      t.string :clno
      t.string :clname
      t.belongs_to :major
      
      t.timestamps
    end
    add_index(:clas, :clno)
  end
end
