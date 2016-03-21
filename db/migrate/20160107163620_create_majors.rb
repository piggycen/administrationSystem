class CreateMajors < ActiveRecord::Migration
  def change
    create_table :majors do |t|
      t.string :mno
      t.string :mname
      t.belongs_to :department

      t.timestamps
    end
    add_index(:majors, :mno)
  end
end
