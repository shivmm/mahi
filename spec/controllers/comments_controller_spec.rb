require 'spec_helper'


describe CommentsController do
  before:all do 
    @u = User.create(:email => "test@gmail.com", :password => "password", :password_confirmation => "password" )
    @my_issue = Issue.create!(:title => "abc", :issue_content =>"Issue Content", :created_at => Time.now, :submitted_by => "test user")
    @c = Comment.create(:user_id => @u.id, :comment_time => Time.now, :body_comments => "test", :location => "abc",:issue_id => @my_issue.id ) 
    
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
        assigns(:comments).should == [@c]
      end
    end#describe logged in
  end#describe index 
  
  describe "show" do
    before :each do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      get :show, {:id => @my_issue.id, :comment => @c }
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
        get :edit, {:id => @my_issue.id}
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
    describe "not logged in" do
      before :each do
        @request.env["devise.mapping"] = Devise.mappings[:user]
        @cc = {:user_id => @u.id, :comment_time => Time.now, :body_comments => "test", :location => "abc",:issue_id => @my_issue.id}
        post :create, {:comment => @cc}
      end
      
      it "should redirect to sign in page" do
        response.should redirect_to(new_user_session_path)
      end
    end #describe not logged in                                                                                                                              
    
    describe "logged in" do
      before :each do
        @request.env["devise.mapping"] = Devise.mappings[:user]
        sign_in @u
        @cc = {:user_id => @u.id, :comment_time => Time.now, :body_comments => "test", :location => "abc",:issue_id => @my_issue.id}
        post :create, {:comment => @cc}
      end
      
      it "should create an comment" do
        expect {post :create, {:comment => @cc}}.to change(Comment, :count).by(1)
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
        @cc = {:user_id => @u.id, :comment_time => Time.now, :body_comments => "test", :location => "abc",:issue_id => @my_issue.id}
        post :update, {:id => @c.id, :comment => @cc }
      end
      
      it "should redirect to sign in page" do
        response.should redirect_to(new_user_session_path)
      end
    end #describe not logged in                                                                                                                              
    
    describe "logged in" do
      before :each do
        @request.env["devise.mapping"] = Devise.mappings[:user]
        @cc = {:user_id => @u.id, :comment_time => Time.now, :body_comments => "test", :location => "abc",:issue_id => @my_issue.id}
        sign_in @u
        post :update, {:id => @c.id, :comment => @cc}
      end
      
      it "should redirect to the comment" do
        response.should redirect_to(@c)
      end
      
      it "should assign correct data" do
        post :update, {:id => @c.id, :comment => @cc} 
        assigns(:comment).should == @c
      end
    end # describe logged in  
  end #describe update 
  
  describe "destroy" do
    describe "not logged in" do
      before :each do
        @request.env["devise.mapping"] = Devise.mappings[:user]
        @c1 = Comment.create(:user_id => @u.id, :comment_time => Time.now, :body_comments => "test", :location => "abc",:issue_id => @my_issue.id )
        post :destroy, {:id => @c1.id}
      end
      
      it "should redirect to sign in page" do
        response.should redirect_to(new_user_session_path)
      end
    end#describe not logged in 
    
    describe "logged in" do
      before :each do
        
        @request.env["devise.mapping"] = Devise.mappings[:user]
        @c1 = Comment.create(:user_id => @u.id, :comment_time => Time.now, :body_comments => "test", :location => "abc",:issue_id => @my_issue.id )
        sign_in @u
      end
      
      it "should redirect correctly" do
        post :destroy, {:id => @c1.id}
        response.should redirect_to(comments_url)
      end
      
      it "should assign correct" do
        post :destroy, {:id => @c1.id}
        assigns(:comment).id.should == @c1.id
      end
      
      it "should destroy a comment" do
        expect {post :destroy, {:id => @c1.id}}.to change(Comment, :count).by(-1)
      end   
    end #Describe logged in   
  end # Describe Destroy
end   


