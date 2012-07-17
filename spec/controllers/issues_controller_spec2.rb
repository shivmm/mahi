require 'spec_helper'

describe IssuesController do
  it_should_behave_like "make_users" do
    before:all do
      Comment.all.destroy!
      Issue.all.destroy!
      @my_issue = FactoryGirl.create(:issue, :user_id => @u.id)
      @other_issue = FactoryGirl.create(:issue, :user_id => @o.id)
    end
    
    context "not logged in" do
      describe "index" do
        before(:each) { get :index }
        
        it("responds ok") { response.should be_ok }
        it("assigns @issues") { assigns(:issues).should == [@my_issue, @other_issue] }
      end 
    end
  
  # describe "new" do 
  
  #  it "should raise an exception" do
    # expect { get :new}.to raise_error(CanCan::Unauthorized)
       # end
     # end  
    it_should_behave_like "logged_in" do
      describe "index" do
        before(:each) { get :index }
        
        it("responds ok") { response.should be_ok }
        it("assigns @issues") { assigns(:issues).should == [@my_issue, @other_issue] }
      end  #index
      
      describe "show" do
        before(:each) { get :show, {:id => @my_issue.id} }
        
        it("responds ok") { response.should be_ok }
        it("assigns @issue") { assigns(:issue).should == @my_issue }
      end #show
      
      describe "new" do
        before(:each) { get :new }
        
        it("responds ok") { response.should be_ok }
        it("assigns @issue") { assigns(:issue).should == Issue.new }
      end #new
      
      describe "edit" do
        describe "own issue" do
          before(:each) { get :edit, {:id => @my_issue.id} }
          
          it("responds ok") { response.should be_ok }
          it("assigns @issue") { assigns(:issue).should == @my_issue}
        end # own issue
        
        describe "other issue" do
          it "should raise CanCan::Unauthorized" do                                       
            expect { get :edit, {:id => @other_issue.id} }.to raise_error(CanCan::Unauthorized)
          end 
        end  #other issue
        
      end #edit
      
      describe "create" do
        before :all do 
          @valid_issue_params = {:title => "abc", :issue_content =>"Issue Content",:user_id => @u.id}        
        end
        before (:each)  { post :create, {:issue => @valid_issue_params} }             
        
        it("assigns @issue") { assigns(:issue).should be_a Issue }
        it("adds an issue") { expect {post :create, {:issue => @valid_issue_params} }.to change(Issue, :count).by(1)}
        it("redirects to new issue") { response.should redirect_to(issue_path(assigns(:issue))) }
      end #create
      
      describe "update" do
        before :all do
          @valid_issue_params = {:title => "abc", :issue_content =>"Issue Content",:user_id => @u.id}        
        end
        describe "my issue" do
          before(:each) {  put :update, {:id => @my_issue.id, :issue => @valid_issue_params} }
          
          it("responds to issue ") { response.should redirect_to (@my_issue) }
          it("assigns @issue") { assigns(:issue).should == @my_issue }
        end #my issue
        
        describe "other issue" do
          it "should raise CanCan::Unauthorized" do
            expect { put :update, {:id => @other_issue.id} }.to raise_error(CanCan::Unauthorized)
          end
        end # other issue
        
      end #update
      
      describe "destroy" do 
        describe "my issue" do 
          
          before(:each) do
            @my_issue1 = FactoryGirl.create(:issue, :user_id => @u.id)
          end
          
          it("assigns @issue") do
            delete :destroy, {:id => @my_issue1.id } 
            assigns(:issue).id.should == @my_issue1.id 
          end
          it("destroy an issue") {  expect {delete :destroy, {:id => @my_issue1.id}}.to change(Issue, :count).by(-1)}
          it("redirects to issue") { 
            delete :destroy, {:id => @my_issue1.id } 
            response.should redirect_to(issues_url) 
          }
        end # describe my issue
        
        
        describe "other issue" do
          it "should raise CanCan::Unauthorized" do
            expect { delete :destroy, {:id => @other_issue.id} }.to raise_error(CanCan::Unauthorized)
          end
        end # other issue
      end # describe destroy    
      
    end # logged in  
  end # make_users 
  
end# IssueController        






