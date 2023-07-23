require 'rails_helper'

#im dumb typo, had `Rspec` instead of `RSpec`
RSpec.describe Kitten, type: :model do
    # sample data to compare against
    subject(:kitten) {
        described_class.new(name: "fluffy", age: "2", cuteness: "8/10", softness: "7.5/10")
    }
    
    #ensures all attributes are fulfilled
    it "valid model w/ valid attributes" do
        #kitten = Kitten.create!
        #attributes = kitten.
        # puts kitten.name -- works
        expect(kitten).to be_valid
    end

    #no kitten name, not valid
    it "invalid without name" do
        puts kitten.name
        kitten.name = nil
        puts kitten.name
        expect(kitten).to_not be_valid
        expect(kitten.errors[:name]).to include("can't be blank")
    end

    it "invalid without age" do
        puts kitten.age
        kitten.age = nil
        puts kitten.age
        expect(kitten).to_not be_valid
        expect(kitten.errors[:age]).to include("can't be blank")
    end

    it "cuteness rating cant use less than 4 char" do
        puts kitten.cuteness
        expect(kitten).to be_valid
        kitten.cuteness = "2/5"
        puts kitten.cuteness
        expect(kitten).to_not be_valid
    end

    it "softness rating cant use less than 4 char" do
        puts kitten.softness
        expect(kitten).to be_valid
        kitten.softness = "4/5"
        puts kitten.softness
        expect(kitten).to_not be_valid
    end
end