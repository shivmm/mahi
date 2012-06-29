require 'spec_helper'


describe IssuesController do
  before:all do
    @issue = Issue.create!(:title => "abc", :issue_content =>"Issue Content", :created_at => Time.now, :submitted_by => "test user")
    @u = User.create(:email => "test@gmail.com", :password => "password", :password_confirmation => "password")
  end
  
  describe "index" do
    describe "not logged in" do
      before :each do
        @request.env["devise.mapping"] = Devise.mappings[:user]
        get :index
      end
      
      it "should redirect to sign in page" do
        response.should redirect_to(new_user_session_path)
      end
      
      it "should assign correct data" do
        assigns(:issues).should == nil
      end
    end

    describe "logged in" do
      before :each do
        @request.env["devise.mapping"] = Devise.mappings[:user]
        sign_in @u
        get :index
      end
      it "should respond ok" do
        response.should be_ok
      end
      
      it "should assign correct data" do
        assigns(:issues).should == [@issue]
      end
    end
      

  end
end
