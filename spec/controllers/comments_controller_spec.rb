require 'spec_helper'


describe CommentsController do
  before :all do
    @my = FactoryGirl.create(:user)
    @other = FactoryGirl.create(:user)
  end 
  
  it_should_behave_like "make_users" do
    
    context "not logged in" do
      before:all do
        Comment.all.destroy!
        Issue.all.destroy!
        @my_issue = FactoryGirl.create(:issue, :user_id => @u.id)
        @my_comment = FactoryGirl.create(:comment, :issue => @my_issue)
        @c = FactoryGirl.create(:comment, :user_id  => @u.id ) 
        @other_comment = FactoryGirl.create(:comment, :user_id => @o.id)
      end
      
      describe "index" do
        before(:each) { get :index }
        
        it "should redirect to root url" do
          response.should redirect_to(root_url)
        end
      end
      
      
      describe "show" do 
        before(:each) { get :show, {:id => @my_comment.id} }
        
        
        it "should redirect to comment issue" do
          response.should redirect_to(issue_path(@my_comment.issue)) 
        end
        
      end#show
      
      
      describe "new" do
        before(:each) {get:new}
        
	it "should redirect to sign in page" do
          response.should redirect_to(new_user_session_path)
	end
      end#new
      
      describe "edit" do
        before(:each) {get :edit, {:id =>@c.id}}
        
	it "should redirect to sign in page" do
          response.should redirect_to(new_user_session_path)
	end
      end#edit
      
      describe "create" do
        before (:each) do                                                                                                                                       
          @valid_attributes = {:body_comments => "body", :location => "Mumbai", :user_id => @u.id, :issue_id => @my_issue.id}   
          post :create, {:comment=> @valid_attributes}
        end
      end#create
      
      
      describe "update" do
        before :each do                                                                                                                                     
          @cc = FactoryGirl.create(:comment, :user_id  => @u.id )
          put :update, {:id => @c.id, :comment => @cc} 
        end                                                                                                                                                
        it "should redirect to sign in page" do
          response.should redirect_to(new_user_session_path)                                       
        end    
      end#update
      
      describe "destroy" do
        before :each do                                                                                                                                     
          @c1 = FactoryGirl.create(:comment, :user_id  => @u.id )                                                                                           
          delete :destroy, {:id => @c1.id }      
        end       
        
        it "should redirect to sign in page" do
          response.should redirect_to(new_user_session_path)
        end
      end#destroy
    end#not logged in
    
    it_should_behave_like "logged_in" do
      before:all do
        Comment.all.destroy!
        Issue.all.destroy!
        @my_issue = FactoryGirl.create(:issue, :user_id => @u.id)
        @my_comment = FactoryGirl.create(:comment, :issue => @my_issue)
        @c = FactoryGirl.create(:comment, :user_id  => @u.id ) 
        @other_comment = FactoryGirl.create(:comment, :user_id => @o.id)
      end
      
      
      describe "index" do
        before(:each) { get :index }
        
        it "should redirect to root url" do
          response.should redirect_to(root_url)
        end
      end #index
      
      describe "show" do
        before(:each) { get :show, {:id => @my_comment.id} }
        
        
        it "should redirect to comment issue" do
          response.should redirect_to(issue_path(@my_comment.issue))
        end       
      end#show     
      
      
      describe "new" do
        before(:each) { get :new }
        
        it("responds ok") { response.should be_ok }
        it("assigns @comment") { assigns(:comment).should == Comment.new }
      end #new
      
      describe "edit" do
        describe "own comment" do
          before(:each) { get :edit, {:id => @c.id} }
          
          it("responds ok") { response.should be_ok }
          it("assigns @comment") { assigns(:comment).should == @c}
        end # own comment
        
        describe "other comment" do
          before(:each) do
            @request.env['HTTP_REFERER'] = comment_path(@other_comment)
            get :edit, {:id => @other_comment.id} 
          end
          
          it "should redirect to the comment" do
            response.should redirect_to(comment_path(@other_comment))
            flash[:error].should match(/not authorized/)
          end  
          
        end #other comment
      end#edit
      
      
      describe "create" do
        before :all do
          @valid_attributes = {:body_comments => "body", :location => "Mumbai", :user_id => @u.id, :issue_id => @my_issue.id}
        end
        before (:each) { post :create, {:comment => @valid_attributes} }
        
        it("assigns @comment") { assigns(:comment).should be_a Comment }
        it("adds an comment") { expect {post :create, {:comment => @valid_attributes} }.to change(Comment, :count).by(1)}
        it("redirects to issue") { response.should redirect_to(issue_path(assigns(:comment).issue)) }
      end #create
      
      
      describe "update" do
        describe "own comment" do
          before :all do                                                                                                                                    
            @valid_attributes = {:body_comments => "body", :location => "Mumbai", :user_id => @u.id, :issue_id => @my_issue.id}                           
            @cc = FactoryGirl.create(:comment, :user_id  => @u.id )
          end     
          before(:each){ put :update, {:id => @cc.id, :comment => {:body_comments => "def"}} }
          
          
          it("responds to comment ") { response.should redirect_to (@cc.issue) }
        end#own comments
        
        describe "other comment" do
          before(:each) do
            @request.env['HTTP_REFERER'] = comment_path(@other_comment)
            @valid_attributes = {:body_comments => "body", :location => "Mumbai", :user_id => @u.id, :issue_id => @my_issue.id}                                  
            put :update, {:id => @other_comment.id, :issue => @valid_attributes }
          end
          
          it "should redirect to the comment" do
            response.should redirect_to(comment_path(@other_comment))
            flash[:error].should match(/not authorized/)
          end
          
        end # other comment
      end#update
      
      describe "destroy" do
        describe "my comment" do
          
          before(:each) do
            @c1 = FactoryGirl.create(:comment, :user_id  => @u.id ) 
          end
          
          it("assigns @comment") do
            delete :destroy, {:id => @c1.id }
            assigns(:comment).id.should == @c1.id
          end
          it("destroy an comment") { expect {delete :destroy, {:id => @c1.id}}.to change(Comment, :count).by(-1)}
          it("redirects to comment") {    delete :destroy, {:id => @c1.id }
            response.should redirect_to(@c1.issue)
          }
        end # describe my comment
        
        
        
        describe "other comment" do
          before(:each) do
            @request.env['HTTP_REFERER'] = comment_path(@other_comment)
            delete :destroy, {:id => @other_comment.id } 
          end
          
          it "should redirect to the comment" do
            response.should redirect_to (comment_path(@other_comment))
            flash[:error].should match(/not authorized/)
          end
        end # other comment
      end # describe destroy 
    end#logged_in
    
    it_should_behave_like "admin_role" do
      before:all do
        Comment.all.destroy!
        Issue.all.destroy!
        
        @my_issue = FactoryGirl.create(:issue, :user_id => @u.id)
        @com = FactoryGirl.create(:comment, :user_id  => @u.id )
        @other_com = FactoryGirl.create(:comment, :user_id => @o.id)
        @my_comment = FactoryGirl.create(:comment, :issue => @my_issue)
      end
      
      describe "index" do
        before :each do
          get :index
        end
        
        it "should redirect to root url" do
          response.should redirect_to(root_url)
        end
      end#index   
      
      
      describe "show" do
        before(:each) { get :show, {:id => @my_comment.id} }
        
        it "should redirect to comment issue" do
          response.should redirect_to(issue_path(@my_comment.issue))
        end
      end#show                
      
      
      describe "new" do
        before(:each) { get :new }
        
        it("responds ok") { response.should be_ok }
        it("assigns @comment") { assigns(:comment).should == Comment.new }
      end #new                                                       
      
      describe "edit" do
        before(:each) { get :edit, {:id => @other_com.id} }
        it("responds ok") { response.should be_ok }
        it("assigns @comment") { assigns(:comment).should == @other_com}
      end # Edit 
      
      describe "create" do
        before :all do
          @valid_attributes1 = {:body_comments => "body", :location => "Mumbai", :user_id => @u.id, :issue_id => @my_issue.id}
        end
        before (:each)  { post :create, {:comment => @valid_attributes1} }
        
        it("assigns @comment") { assigns(:comment).should be_a Comment }
        it("adds an comment") { expect {post :create, {:comment => @valid_attributes1} }.to change(Comment, :count).by(1)}
        it("redirects to issue") { response.should redirect_to(issue_path(assigns(:comment).issue)) }
        
      end #create   
      
      describe "update" do
        before :all do
          @cc = FactoryGirl.create(:comment, :user_id  => @u.id )
        end
        before(:each){ put :update, {:id => @cc.id, :comment => {:body_comments => "def"}} }
        
        
        it("it should redirect to issue") { response.should redirect_to (@cc.issue) }
    
      end # update
      
      describe "destroy" do
        before(:each) do
          @other_com1 = FactoryGirl.create(:comment, :user_id  => @other_com.id )
        end
        
        it("assigns @comment") do
          delete :destroy, {:id => @other_com1.id }
          assigns(:comment).id.should == @other_com1.id
        end
        it("destroy an comment") { expect {delete :destroy, {:id => @other_com1.id}}.to change(Comment, :count).by(-1)}
        it("redirects to comment") {
          delete :destroy, {:id => @other_com1.id }
          response.should redirect_to(@other_com1.issue)
        }  
      end#destroy    
    end#adminrole  
    
  end#make_users
end#commentscontoller





