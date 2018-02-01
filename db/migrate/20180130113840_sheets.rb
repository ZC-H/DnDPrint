class Sheets < ActiveRecord::Migration[5.1]
  def change
  	create_table :sheets do |t|
     	t.string :name
     	t.string :race
     	t.string :gender
      t.string :campaign
     	t.string :background
     	t.string :classes #Currently only one class is allowed, to be expanded later
     	t.integer :hp
     	t.integer :level
     	t.integer :initiative
     	t.integer :ac
      t.integer :profbonus
     	t.text	:abilityscores
     	t.text	:saves
     	t.text	:skillmods
      t.text	:classfeatures
     	t.text	:attacks
      t.belongs_to	:user
      t.timestamps
    end
  end
end
