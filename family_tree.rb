require 'bundler/setup'
require 'pry'
Bundler.require(:default)
Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }

database_configurations = YAML::load(File.open('./db/config.yml'))
development_configuration = database_configurations['development']
ActiveRecord::Base.establish_connection(development_configuration)


system "clear"
def menu
  puts 'Welcome to the family tree!'
  puts 'What would you like to do?'

  loop do
    puts 'Press a to add a family member.'
    puts 'Press l to list out the family members.'
    puts 'Press p to add parent relationships'
    puts 'Press m to add who someone is married to.'
    puts 'Press s to see who someone is married to.'
    puts "Press c to see all of the married couples"
    puts "Press d to see parents"
    puts "Press g to see grandparents"
    puts 'Press e to exit.'
    choice = gets.chomp

    case choice
    when 'a'
      add_person
    when 'l'
      list
    when 'p'
      list
      puts "Is the child already in the family tree? 'Y' or 'N'"
      input = gets.chomp
      case input
      when 'y'
        puts "Enter the number of the child"
        child = Person.all[gets.chomp.to_i - 1]
        add_parent(child)
      when 'n'
        puts "Please add child to the database first"
        add_person
      end
    when 'm'
      add_marriage
    when 's'
      show_marriage
    when 'c'
      show_couples
    when 'd'
      show_parents
    when 'g'
      show_grandparents
    when 'e'
      exit
    end
  end
end

def add_person
  puts 'What is the name of the family member?'
  name = gets.chomp
  new_person = Person.create(:name => name)
  puts name + " was added to the family tree.\n\n"
  puts "Would you like to add a parent for " + name + " 'Y' or 'N'"
  input = gets.chomp.downcase
  case input
  when 'y'
    add_parent(new_person)
  when 'n'
  else
    puts "That is not a valid option"
  end
end

def add_parent(child)
  list
  puts "Are the parents on the list? 'Y' or 'N'"
  input = gets.chomp.downcase
  case input
  when 'y'
    puts "\nEnter the number of one of the parents"
    p1 = Person.all[gets.chomp.to_i - 1]
    puts "\nEnter the number of the other parent"
    p2 = Person.all[gets.chomp.to_i - 1]
    new_parentobj = Parent.create(:parent1_id => p1.id, :parent2_id => p2.id)
    child.update(:parent_id => new_parentobj.id)

    parent1 = Person.find(p1.id)
    parent2 = Person.find(p2.id)
    puts "\n#{parent1.name} and #{parent2.name} have been added as #{child.name}'s parents\n\n"
  when 'n'
    puts "Add the parents to the family tree"
    add_person
  end
end


# def add_brother
#   Brother.create(:)
# end

def add_marriage
  list
  puts 'What is the number of the first spouse?'
  spouse1 = Person.all[gets.chomp.to_i - 1]
  puts 'What is the number of the second spouse?'
  spouse2 = Person.all[gets.chomp.to_i - 1]
  new_couple = Couple.create(:person1_id => spouse1.id, :person2_id => spouse2.id)
  puts "#{spouse1.name} is now married to #{spouse2.name}"
  spouse1.update(:couple_id => new_couple.id)
  spouse2.update(:couple_id => new_couple.id)
end

def list
  puts 'Here are all your relatives:'
  people = Person.all
  current_people = people.each_with_index do |person, index|
    puts "#{index+1}" + " " + person.name
  end
  puts "\n"
end

def show_grandparents


end


def show_couples
  Couple.all.each do |couple|
    person1 = Person.find(couple.person1_id)
    person2 = Person.find(couple.person2_id)
    puts "#{person1.name} and #{person2.name} are married"
  end
end

def show_marriage
  list
  puts "Enter the number of the relative and I'll show you who they're married to."
  person = Person.all[gets.chomp.to_i - 1]
  couple_array = person.show_couple(person)
  puts "\n\n#{couple_array[0]} is married to #{couple_array[1]}\n\n"
end

def show_parents
  list
  puts "Enter a number of a person you want to see the parents for"
  person = Person.all[gets.chomp.to_i - 1]
  parent1 = Person.find(person.parent.parent1_id)
  parent2 = Person.find(person.parent.parent2_id)
  puts "\n\n#{person.name}'s parents are #{parent1.name} and #{parent2.name}.\n"
  puts "\nWould you like to see all parents and their respective children? Y/N"
  if gets.chomp.upcase == "Y"

    Parent.all.each do |parent|
      parents = []
      person1 = Person.find(parent.parent1_id)
      parents << person1.name
      person2 = Person.find(parent.parent2_id)
      parents << person2.name
      children = Person.where(:parent_id => parent.id)
      children_names =[]
      children.each { |child| children_names << child.name }
      puts "\n#{parents[0]} and #{parents[1]} are the parents of #{children_names.join(', ')}"
    end
    puts "\n\n\n"
  elsif gets.chomp.upcase == 'N'

  else
    puts "That is not a valid entry. Please try again."
  end
end

menu

