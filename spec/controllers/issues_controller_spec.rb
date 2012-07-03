require 'spec_helper'


describe IssuesController do
  before:all do
    @my_issue = Issue.create!(:title => "abc", :issue_content =>"Issue Content", :created_at => Time.now, :submitted_by => "test user")
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
        assigns(:issues).should == [@my_issue]
      end
    end
    
    describe "show" do
      before :each do
        @request.env["devise.mapping"] = Devise.mappings[:user]
        get :show, {:id => @my_issue.id}
      end
      
      it "should respond ok" do
        response.should be_ok
      end

      it "should render show template" do
        response.should render_template(:show)
      end

      it "should assign correct data" do 
        assigns(:issue).should == @my_issue
      end
    end
    
  end # describe show
  
  describe "new" do
    describe "not logged in" do
      before :each do
        @request.env["devise.mapping"] = Devise.mappings[:user]
        get :new
      end
      
      it "should redirect to sign in page" do
        response.should redirect_to(new_user_session_path)
      end

    end #describe not logged in

    describe "logged in" do
      before :each do
        @request.env["devise.mapping"] = Devise.mappings[:user]
        sign_in @u
        get :new
      end

      it "should render new template" do
        response.should render_template(:new)
      end

      it "should assign correct data" do
        assigns(:issue).should == Issue.new 
      end

      it "should respond ok" do
        response.should be_ok 
      end
      
    end # describe logged in

  end #describe new

  describe "edit" do
    describe "not logged in" do
      before :each do
        @request.env["devise.mapping"] = Devise.mappings[:user]
        get :edit, {:id => @my_issue.id}
      end
      
      it "should redirect to sign in page" do
        response.should redirect_to(new_user_session_path)
      end
    end #describe not logged in
    
    describe "logged in" do
      before :each do
        @request.env["devise.mapping"] = Devise.mappings[:user]
        sign_in @u
        get :edit, {:id => @my_issue.id}
      end
      
      it "should render new template" do
        response.should render_template(:edit)
      end
      
      it "should assign correct data" do
        assigns(:issue).should == @my_issue
      end
      
      it "should respond ok" do
        response.should be_ok
      end
      
    end # describe logged in    
    
  end #describe edit
end


  
      
      
  
