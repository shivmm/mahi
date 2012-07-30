require 'spec_helper'

describe Comment do
  it { should have_property(:created_at).of_type(DataMapper::Property::DateTime)}
  it { should have_property(:body_comments).of_type(DataMapper::Property::Text)}
  it { should belong_to(:issue)}
  it { should belong_to(:user)}

  it{ should validate_presence_of(:body_comments)}

  describe "comment count" do
    context "creation" do
      it "should update the comment count on the Issue" do
        @issue = FactoryGirl.create(:issue)
        @user2 = FactoryGirl.create(:user)
        @comment = Comment.new(:body_comments => "abc def", :user_id => @user2.id, :issue_id => @issue.id, :location => "def")
        @comment.save
        @issue.reload
        @issue.comment_count.should == 1
      end  
    end

    context "updation" do
      it "should not update the comment count if updated" do
        @issue = FactoryGirl.create(:issue)
        @user2 = FactoryGirl.create(:user)
        @comment = Comment.new(:body_comments => "abc def", :user_id => @user2.id, :issue_id => @issue.id, :location => "def")
        @comment.save
        @comment.location = "afgvsafv"
        @comment.save
        @issue.reload
        @issue.comment_count.should == 1
      end
    end
  end
end

