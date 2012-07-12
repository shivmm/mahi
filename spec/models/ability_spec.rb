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
      before :each do 
        @comment = FactoryGirl.create(:comment, :user => @u)
        @other_comment = FactoryGirl.create(:comment, :user => @o)
      end
      
      describe "my own comment" do
        it "should have all access" do
          @ability.should be_able_to(:access, @comment)
        end
      end # my own comment
      
      describe "others' comment" do
        it "should be able to read" do
          @ability.should be_able_to(:read, @other_comment)
        end
        
        it "should not be able to update other comment" do
          @ability.should_not be_able_to(:update, @other_comment)
        end
        
        it "should not be able to delete other comment" do
          @ability.should_not be_able_to(:delete, @other_comment)
        end  
      end #others
    end #comments
    
  end # as user
end  
