class CreateStudents < ActiveRecord::Migration
  def change
    create_table :students do |t|
      t.string :sno
      t.string :sname
      t.string :ssex
      t.date :sbirthday
      t.string :splace
      t.string :spassport
      t.string :sgetin
      t.string :schooling
      t.string :snation
      t.belongs_to :cla

      t.timestamps
    end
    add_index(:students, :sno)
  end
end
