class Person < ActiveRecord::Base
  validates :name, :presence => true
  belongs_to(:couple)
  belongs_to(:parent)


  def show_couple(person)
    couple = []
    couple_obj = person.couple
    person1_num = couple_obj.person1_id
    person1 = Person.find(person1_num)
    couple << person1.name
    person2_num = couple_obj.person2_id
    person2 = Person.find(person2_num)
    couple << person2.name
    couple
  end

def self.show_grandpeople

  people_with_parents = Person.where("parent_id IS NOT NULL")
  people_with_parents.each do |person|
    grandparents = []
    grandchildren = []

    p1 = Person.find(person.parent.parent1_id)
    p2 = Person.find(person.parent.parent2_id)
    if "p1.parent_id IS NOT NULL"  #p1.parent_id != nil
      gp1 = Person.find(p1.parent.parent1_id)
      grandparents << gp1.name
      gp2 = Person.find(p1.parent.parent2_id)
      grandparents << gp2.name
    end
    if "p2.parent_id IS NOT NULL"
      gp3 = Person.find(p2.parent.parent1_id)
      grandparents << gp3.name
      gp4 = Person.find(p2.parent.parent2_id)
      grandparents << gp4.name
    end
    if "p1.parent_id IS NOT NULL" || "p2.parent_id IS NOT NULL"
      grandchildren << person.name
    end
    grandparents
    grandchildren
  end
end


private

end
