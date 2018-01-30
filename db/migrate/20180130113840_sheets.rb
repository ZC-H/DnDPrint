class Sheets < ActiveRecord::Migration[5.1]
  def change
  	create_table :sheets do |t|
     	t.string :name
     	t.string :race
     	t.string :gender
     	t.string :background
     	t.string :classes #Currently only one class is allowed, to be expanded later
     	t.integer :hp
     	t.integer :level
     	t.integer :initiative
     	t.integer :ac
     	t.text	:abilityscores, array: true, default: [nil,nil,nil,nil,nil,nil]
     	t.text	:saveprofs, array: true, default: []
     	t.text	:skillmods, array: true, default: [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
     	t.text	:skillprofs, array: true, default: []
     	t.text	:classfeatures, array: true, default: []
     	t.text	:attacks, array: true, default: []
      t.belongs_to	:user
      t.timestamps
    end
  end
end
