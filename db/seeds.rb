# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


user = {}
user['password'] = 'aaaa'
#user['password_confirmation'] = 'aaaa'

def random_name
  name=""
  letters = ['a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z']
  vowels = ['a','e','i','o','u']
  (2+rand(3)).times { name << letters.sample + vowels.sample }
  name.capitalize
end

ActiveRecord::Base.transaction do
  20.times do 
  	first_name = random_name
    user['name'] = first_name + " " + random_name
    user['email'] = first_name + "@email.com"
    user['role'] = 0
    User.create(user)
  end
end 


sheet = {}
uids = []
User.all.each { |u| uids << u.id }

ActiveRecord::Base.transaction do
  40.times do 
  	sheet['level'] = 1 + rand(20)
  	sheet['name'] = random_name + " " + random_name
  	sheet['classes'] = ["Artificer","Barbarian","Bard","Cleric","Druid","Fighter","Monk","Mystic","Paladin","Ranger","Rogue","Sorcerer","Warlock","Wizard"].sample
  	sheet['race'] = ["Human","Elf","Dwarf","Half-Elf","Tiefling","Aasimar","Aarakocra"].sample
    sheet['abilityscores'] = {}
    ['str','dex','con','int','wis','cha'].each do |s|
      rolls = [1+rand(6),1+rand(6),1+rand(6),1+rand(6)]
      rolls.delete(rolls.min)
      sheet['abilityscores'][s] = rolls.inject(:+)
    end
  	sheet['user_id'] = uids.sample
  	a = Sheet.create(sheet)
    a.autocalc_all
    a.save
  end
end