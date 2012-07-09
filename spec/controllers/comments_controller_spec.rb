require 'spec_helper'


describe CommentsController do
  before:all do 
    @u = FactoryGirl.create(:user)
    @my_issue = FactoryGirl.create(:issue, :user_id => @u.id)
    @c = FactoryGirl.create(:comment, :user_id  => @u.id ) 
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
        assigns(:comment).should == nil
      end
    end#describe not logged in 
    
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
        assigns(:comments).should == [@c]
      end
    end#describe logged in
  end#describe index 
  
  describe "show" do
    before :each do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      get :show, {:id => @c.id }
    end
    
    it "should respond ok" do
      response.should be_ok
    end
    
    it "should render show template" do
      response.should render_template(:show)
    end
    
    it "should assign correct data" do
      assigns(:comment).should == @c
    end
  end #describe show                                 
  
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
        assigns(:comment).should == Comment.new
      end
      
      it "should respond ok" do
        response.should be_ok
      end
      
    end # describe logged in         
  end # describe new    
  
  describe "edit" do 
    describe "not logged in" do 
      before :each do 
        @request.env["devise.mapping"] = Devise.mappings[:user]
        get :edit, {:id => @c.id}
      end 
      it "should redirect to sign in page" do
        response.should redirect_to(new_user_session_path)  
      end
    end #describe not logged in 
    
    describe "logged in" do
      before :each do
        @request.env["devise.mapping"] = Devise.mappings[:user]
        sign_in @u
        get :edit, {:id => @c.id}
      end
      
      it "should render new template" do
        response.should render_template(:edit)
      end
      
      it "should assign correct data" do
        assigns(:comment).should == @c
      end
      
      it "should respond ok" do
        response.should be_ok
      end
    end # describe logged in
  end #describe edit
  
  describe "create" do
    before :all do
      @valid_attributes = {:body_comments => "body", :location => "Mumbai", :user_id => @u.id, :issue_id => @my_issue.id}
    end
    describe "not logged in" do
      before :each do
        @request.env["devise.mapping"] = Devise.mappings[:user]
        post :create, {:comment => @valid_attributes}
      end
      
      it "should redirect to sign in page" do
        response.should redirect_to(new_user_session_path)
      end
    end #describe not logged in                                                                                                                              
    
    describe "logged in" do
      before :each do
        @request.env["devise.mapping"] = Devise.mappings[:user]
        sign_in @u
        post :create, {:comment => @valid_attributes}
      end
      
      it "should create an comment" do
        expect {post :create, {:comment => @valid_attributes}}.to change(Comment, :count).by(1)
      end
      
      it "should redirect to the comment" do
        response.should redirect_to(comment_path(Comment.last))
      end
      
      it "should assign correct data" do
        assigns(:comment).should == Comment.last
      end
    end # describe logged in  
  end # describe create
  
  
  describe "update" do 
    describe "not logged in" do
      before :each do
        @request.env["devise.mapping"] = Devise.mappings[:user]
        @cc = FactoryGirl.create(:comment, :user_id  => @u.id )
        put :update, {:id => @c.id, :comment => @cc }
      end
      
      it "should redirect to sign in page" do
        response.should redirect_to(new_user_session_path)
      end
    end #describe not logged in                                                                                                                              
    
    describe "logged in" do
      before :all do
        @valid_attributes = {:body_comments => "body", :location => "Mumbai", :user_id => @u.id, :issue_id => @my_issue.id}
      end

      before :each do
        @request.env["devise.mapping"] = Devise.mappings[:user]
        @cc = FactoryGirl.create(:comment, :user_id  => @u.id )
        sign_in @u
        put :update, {:id => @cc.id, :comment => {:body_comments => "def"}}
      end
      
      it "should redirect to the comment" do
        response.should redirect_to(@cc)
      end
      
      it "should call correct method" do
        Comment.any_instance.should_receive(:update).with("body_comments" => "def")
        put :update, {:id => @cc.id, :comment => {:body_comments => "def"}}
      end

      it "should assign correct data" do
        assigns(:comment).should == @cc
      end

    end # describe logged in  
  end #describe update 
  
  describe "destroy" do
    describe "not logged in" do
      before :each do
        @request.env["devise.mapping"] = Devise.mappings[:user]
        @c1 = FactoryGirl.create(:comment, :user_id  => @u.id )
        delete :destroy, :id => @c1.id
      end
      
      it "should redirect to sign in page" do
        response.should redirect_to(new_user_session_path)
      end
    end#describe not logged in 
    
    describe "logged in" do
      before :each do
        
        @request.env["devise.mapping"] = Devise.mappings[:user]
        @c1 = FactoryGirl.create(:comment, :user_id  => @u.id )
        sign_in @u
      end
      
      it "should redirect correctly" do
        delete :destroy, :id => @c1.id
        response.should redirect_to(comments_url)
      end
      
      it "should assign correct" do
        delete :destroy, :id => @c1.id
        assigns(:comment).id.should == @c1.id
      end
      
      it "should destroy a comment" do
        expect {post :destroy, {:id => @c1.id}}.to change(Comment, :count).by(-1)
      end   
    end #Describe logged in   
  end # Describe Destroy
end   


  
