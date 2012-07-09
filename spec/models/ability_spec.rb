require "spec_helper"
require "cancan/matchers"

describe Ability do

  context "as user" do

    before :all do
      @u = FactoryGirl.create(:user)
      @o = FactoryGirl.create(:user)
      @ability = Ability.new(@u)
    end
    
    describe "issues" do
      before :each do
        @issue = FactoryGirl.create(:issue, :user => @u)
        @other_issue = FactoryGirl.create(:issue, :user => @o)
      end

      describe "my own issues" do
        it "should have all access" do
          @ability.should be_able_to(:access, @issue)
        end
      end

      describe "other issue" do
        it "should be able to read" do
          @ability.should be_able_to(:read, @other_issue)
        end
        it "should not be able to update other issue" do
          @ability.should_not be_able_to(:update, @other_issue)
        end
        it "should not be able to delete other issue" do
          @ability.should_not be_able_to(:delete, @other_issue)
        end
        
      end #other issue
    end #issues

    describe "comments" do
      describe "my own" do
      end # my own
      describe "others" do
      end #others
    end #comments
    
  end # as user
end
