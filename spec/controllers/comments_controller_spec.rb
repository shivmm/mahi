require 'spec_helper'


describe CommentsController do
  it_should_behave_like "make_users" do
    
    context "not logged in" do
      before:all do
        Comment.all.destroy!
        Issue.all.destroy!
        @my_issue = FactoryGirl.create(:issue, :user_id => @u.id)
        @c = FactoryGirl.create(:comment, :user_id  => @u.id ) 
        @other_comment = FactoryGirl.create(:comment, :user_id => @o.id)
      end
  
      describe "index" do 
        
        it "should raise CanCan::Unauthorized" do
          expect { get :index}.to raise_error(CanCan::Unauthorized)
        end
      end #index 

      describe "show" do
        it "should raise CanCan::Unauthorized" do
          expect { get :index}.to raise_error(CanCan::Unauthorized)
        end 
      end#show
      
      describe "new" do
        it "should raise CanCan::Unauthorized" do
          expect { get :new}.to raise_error(CanCan::Unauthorized)                                                         
        end         
      end#new

      describe "edit" do
        it "should raise CanCan::Unauthorized" do 
          expect { get :edit, {:id => @c.id} }.to raise_error(CanCan::Unauthorized)                                                                          
        end                    
      end#edit

      describe "create" do
        before :all do                                                                                                                                         
          @valid_attributes = {:body_comments => "body", :location => "Mumbai", :user_id => @u.id, :issue_id => @my_issue.id}   
        end
        it "should raise CanCan::Unauthorized" do                                                                                                            
          expect { post :create, {:comment=> @valid_attributes} }.to raise_error(CanCan::Unauthorized)                                                       
        end  
      end#create
      
      describe "update" do
        before :each do                                                                                                                                      
          @cc = FactoryGirl.create(:comment, :user_id  => @u.id )                                                                                            
        end                                                                                                                                                  
        it "should raise CanCan::Unauthorized" do                                                                                                            
          expect { put :update, {:id => @c.id, :comment => @cc} }.to raise_error(CanCan::Unauthorized)                                                       
        end    
      end#update

      describe "destroy" do
        before :each do                                                                                                                                      
          @c1 = FactoryGirl.create(:comment, :user_id  => @u.id )                                                                                            
        end                                                                                                                                                  
        
        it "should raise CanCan::Unauthorized" do                                                                                                            
          expect { delete :destroy, {:id => @c1.id } }.to raise_error(CanCan::Unauthorized)                                                                  
        end  
      end#destroy

    end#not logged in

    it_should_behave_like "logged_in" do
      before:all do
        Comment.all.destroy!
        Issue.all.destroy!
        @my_issue = FactoryGirl.create(:issue, :user_id => @u.id)
        @c = FactoryGirl.create(:comment, :user_id  => @u.id ) 
        @other_comment = FactoryGirl.create(:comment, :user_id => @o.id)
      end

      
      describe "index" do
        before(:each) { get :index }
        
        it("responds ok") { response.should be_ok }
        it("assigns @comments") { assigns(:comments).should == [@c, @other_comment] }
      end #index

      describe "show" do
        before(:each) { get :show, {:id => @c.id} }
        
        it("responds ok") { response.should be_ok }
        it("assigns @comment") { assigns(:comment).should == @c }
      end #show
      
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
          it "should raise CanCan::Unauthorized" do
            expect { get :edit, {:id => @other_comment.id} }.to raise_error(CanCan::Unauthorized)
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
        it("redirects to new comment") { response.should redirect_to(comment_path(assigns(:comment))) }
      end #create


      describe "update" do
        describe "own comment" do
          before :all do                                                                                                                                     
            @valid_attributes = {:body_comments => "body", :location => "Mumbai", :user_id => @u.id, :issue_id => @my_issue.id}                              
            @cc = FactoryGirl.create(:comment, :user_id  => @u.id )
          end     
            before(:each){ put :update, {:id => @cc.id, :comment => {:body_comments => "def"}} }
                 
          
          it("responds to comment ") { response.should redirect_to (@cc) }
          it("assigns @comment") { assigns(:comment).should == @cc }        
        end#own comments
        
        describe "other comment" do
          it "should raise CanCan::Unauthorized" do
            expect { put :update, {:id => @other_comment.id} }.to raise_error(CanCan::Unauthorized)
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
          it("redirects to comment") {
            delete :destroy, {:id => @c1.id }
            response.should redirect_to(comments_url)
          }
        end # describe my comment
        
        
        describe "other comment" do
          it "should raise CanCan::Unauthorized" do
            expect { delete :destroy, {:id => @other_comment.id} }.to raise_error(CanCan::Unauthorized)
          end
        end # other comment
      end # describe destroy 
    end#logged_in
  end#make_users
end#commentscontoller


  
  
  
