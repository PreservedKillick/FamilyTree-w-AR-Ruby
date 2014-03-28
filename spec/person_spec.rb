require 'spec_helper'

describe Person do
  it { should validate_presence_of :name }

  it { should belong_to :couple }
  it { should belong_to :parent}


  it "is nil if they aren't married" do
    earl = Person.create(:name => 'Earl')
    earl.couple_id.should be_nil
  end

  describe "show_couple" do
    it "should give you the name of the person the requested person is married to" do
      person1 = Person.create(:name => 'Walter')
      person2 = Person.create(:name => 'Skylar')
      couple = Couple.create(:person1_id => person1.id, :person2_id => person2.id)
      person1.update(:couple_id => couple.id)
      person2.update(:couple_id => couple.id)
      person = person1
      person1.show_couple(person).should eq ["Walter", "Skylar"]
    end
  end

  describe '.show_grandpeople' do
    it "should list all the grandparents of each grandchild" do
      person1 = Person.create(:name => 'Walter', :id => 1)
      person2 = Person.create(:name => 'Skylar',  :id => 2, :parent_id => 2)
      grandkid = Person.create(:name => 'Joe', :parent_id => 1)
      grandparent = Person.create(:name => 'Old', :id => 4)
      grandparent2 = Person.create(:name => 'AsOld', :id => 5)
      Parent.create(:parent1_id => 1, :parent2_id => 2, :id => 1)
      Parent.create(:parent1_id => 4, :parent2_id => 5, :id => 2)

      Person.show_grandpeople.should eq ['Old', 'AsOld'] ['Joe']
    end
  end
end
