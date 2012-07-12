require 'spec_helper'


describe IssuesController do
  before:all do
    @u = FactoryGirl.create(:user)
    @o = FactoryGirl.create(:user)
    @my_issue = FactoryGirl.create(:issue, :user_id => @u.id)
    @other_issue = FactoryGirl.create(:issue, :user_id => @o.id)
  end
  
  describe "index" do
    describe "not logged in" do
      before :each do
        @request.env["devise.mapping"] = Devise.mappings[:user]
        get :index
      end      
      it "should redirect to sign in page" do
        response.should be_ok
      end
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
      assigns(:issues).should == [@my_issue, @other_issue]
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
  end # describe show

  describe "new" do
    describe "not logged in" do
      before :each do
        @request.env["devise.mapping"] = Devise.mappings[:user]
      end
      
      it "should raise an exception" do
        expect { get :new}.to raise_error(CanCan::Unauthorized)
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
      end
      
      it "should raise an exception" do
        expect { get :edit, {:id => @my_issue.id} }.to raise_error(CanCan::Unauthorized)
      end
    end #describe not logged in
    
    describe "logged in" do
      describe "my issues" do
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
      end #my issue
      
      describe "others' issue" do
        before :each do
          @request.env["devise.mapping"] = Devise.mappings[:user]
          sign_in @u
        end
        
        it "should raise CanCan::Unauthorized" do
          expect { get :edit, {:id => @other_issue.id} }.to raise_error(CanCan::Unauthorized)
        end
      end # others issue
    end # describe logged in    
    
  end #describe edit
  
  describe "create" do
    describe "not logged in" do
      before :each do
        @request.env["devise.mapping"] = Devise.mappings[:user]
        @valid_issue_params = {:title => "abc", :issue_content =>"Issue Content"}
      end
      
      it "should raise CanCan::Unauthorized" do
        expect { post :create, {:issue => @valid_issue_params} }.to raise_error(CanCan::Unauthorized)         
      end
    end #describe not logged in                                                                                                                              
    
    describe "logged in" do
      before :each do
        @request.env["devise.mapping"] = Devise.mappings[:user]
        sign_in @u
        @valid_issue_params = {:title => "abc", :issue_content =>"Issue Content",:user_id => @u.id}
        post :create, {:issue => @valid_issue_params}
      end
      
      it "should create an issue" do
        expect {post :create, {:issue => @valid_issue_params}}.to change(Issue, :count).by(1)
      end
      
      it "should redirect to the issue" do
        response.should redirect_to(issue_path(Issue.last))
      end
      
      it "should assign correct data" do
        assigns(:issue).should == Issue.last
      end
      
    end # describe login in  
  end # describe create
  
  describe "update" do 
    describe "not logged in" do
      before :each do
        @request.env["devise.mapping"] = Devise.mappings[:user]
        @valid_issue_params ={:title => "abc", :issue_content =>"Issue Content",:user_id => @u.id} 
      end
      
      it "should raise CanCan::Unauthorized" do        
        expect { put :update, {:id => @my_issue.id, :issue => @valid_issue_params } }.to raise_error(CanCan::Unauthorized)
      end
    end #describe not logged in                                                                                                                              
    
    describe "logged in" do
      describe "my issue" do 
        before :each do
          @request.env["devise.mapping"] = Devise.mappings[:user]
          @valid_issue_params = {:title => "abc", :issue_content =>"Issue Content",:user_id => @u.id}
          sign_in @u
          put :update, {:id => @my_issue.id, :issue => @valid_issue_params}
        end
        
        it "should redirect to the issue" do
          response.should redirect_to(@my_issue)
        end
        
        it "should assign correct data" do
          put :update, {:id => @my_issue.id, :issue => @valid_issue_params} 
          assigns(:issue).should == @my_issue
        end
      end # describe my issue  
    end # describe logged  in  
    
    describe "others' issue" do
      before :each do
        @request.env["devise.mapping"] = Devise.mappings[:user]
        sign_in @u
      end
      
      it "should raise CanCan::Unauthorized" do
        expect { put :update, {:id => @other_issue.id, :issue => @valid_issue_params } }.to raise_error(CanCan::Unauthorized)
      end
    end # describe other login
  end # describe update
  
  describe "destroy" do
    describe "not logged in" do
      before :each do
        @request.env["devise.mapping"] = Devise.mappings[:user]
        @my_issue1 = FactoryGirl.create(:issue)
      end
      
      it "should raise CanCan::Unauthorized" do        
        expect { delete :destroy, {:id => @my_issue1.id } }.to raise_error(CanCan::Unauthorized)
      end
    end # describe not logged in 
    
    describe "logged in" do
      describe "my issue" do 
        before :each do        
          @request.env["devise.mapping"] = Devise.mappings[:user]
          @my_issue1 = FactoryGirl.create(:issue, :user => @u)
          sign_in @u
        end
        
        it "should redirect correctly" do
          delete :destroy,:id => @my_issue1.id
          response.should redirect_to(issues_url)
        end
        
        it "should assign correct" do
          delete :destroy, :id => @my_issue1.id
          assigns(:issue).id.should == @my_issue1.id
        end
        
        it "should destroy an issue" do
          expect {delete :destroy, {:id => @my_issue1.id}}.to change(Issue, :count).by(-1)
        end   
      end #Describe my issue 
    end # describe logged in  
    
    describe "others' issue" do
      before :each do
        @request.env["devise.mapping"] = Devise.mappings[:user]
        sign_in @u
      end
      
      it "should raise CanCan::Unauthorized" do
        expect { delete :destroy, {:id => @other_issue.id} }.to raise_error(CanCan::Unauthorized)
      end
    end # Describe other issue  
  end # Describe destory 
end # Describe IssuesController  




