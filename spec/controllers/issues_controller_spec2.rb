
require 'spec_helper'

describe IssuesController do
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
        @other_issue = FactoryGirl.create(:issue, :user_id => @o.id)
      end
      
      describe "index" do
        before(:each) { get :index }
        
        it("responds ok") { response.should be_ok }
        it("assigns @issues") { assigns(:issues).should == [@my_issue, @other_issue] }
      end 
      
      describe "show" do
        before(:each) { get :show, {:id => @my_issue.id} }
        
        it("responds ok") { response.should be_ok }
        it("assigns @issue") { assigns(:issue).should == @my_issue }
      end #show   
      
      describe "new" do
        before(:each) {get :new }
        
        it "should redirect to sign in page" do
          response.should redirect_to(new_user_session_path)
        end
      end#new
      
      describe "edit" do 
        before(:each) {get :edit, {:id =>@my_issue.id}}
        
        it "should redirect to sign in page" do
          response.should redirect_to(new_user_session_path)
        end
      end #edit
      
      describe "create" do
        before :each do
          @valid_issue_params = {:title => "abc", :issue_content =>"Issue Content"}
          post :create, {:issue => @valid_issue_params}
        end
        
        it "should redirect to sign in page" do
          response.should redirect_to(new_user_session_path)
        end
      end#create
      
      describe "update" do
        before :each do
          @valid_issue_params = {:title => "abc", :issue_content =>"Issue Content"}
          put :update, {:id =>@my_issue.id, :issue =>@valid_issue_params}
        end
        it "should redirect to sign in page" do
          response.should redirect_to(new_user_session_path)
        end
      end#update
      
      describe "destroy" do
        before :each do 
          @my_issue1 = FactoryGirl.create(:issue, :user_id => @u.id)
          delete :destroy, {:id => @my_issue1.id } 
        end
        
        it "should redirect to sign in page" do
          response.should redirect_to(new_user_session_path)
        end
      end
    end#not logged in
    
    
    it_should_behave_like "logged_in" do
      before:all do
        Comment.all.destroy!
        Issue.all.destroy!
        @my_issue = FactoryGirl.create(:issue, :user_id => @u.id)
        @other_issue = FactoryGirl.create(:issue, :user_id => @o.id)
      end

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
          before(:each) do
            @request.env['HTTP_REFERER'] = issue_path(@other_issue)
            get :edit, {:id => @other_issue.id} 
          end
          
          it "should redirect to the issue" do
            response.should redirect_to(issue_path(@other_issue))
            flash[:error].should match(/not authorized/)
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
          it("should receive proper message") { Issue.any_instance.should_receive(:save);put :update, {:id => @my_issue.id, :issue => @valid_issue_params} }
        end #my issue
        
        describe "other issue" do
          before(:each) do
            @request.env['HTTP_REFERER'] = issue_path(@other_issue)
            @valid_issue_params = {:title => "abc", :issue_content =>"Issue Content",:user_id => @u.id}        
            put :update, {:id => @other_issue.id, :issue => @valid_issue_params }
          end
          
          it "should redirect to the issue" do
            response.should redirect_to(issue_path(@other_issue))
            flash[:error].should match(/not authorized/)
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
          before(:each) do
            @request.env['HTTP_REFERER'] = issue_path(@other_issue)
            delete :destroy, {:id => @other_issue.id } 
          end
          
          it "should redirect to the issue" do
            response.should redirect_to (issue_path(@other_issue))
            flash[:error].should match(/not authorized/)
            
          end
        end # other issue
      end # describe destroy    
      
    end # logged in  
  end # make_users  
  
  
  it_should_behave_like "admin_role" do
    before:all do
      Comment.all.destroy!
      Issue.all.destroy!
      @my_issue12 = FactoryGirl.create(:issue, :user_id => @my.id)
      @other_issue12 = FactoryGirl.create(:issue, :user_id => @other.id)
    end
    
    describe "index" do
      before :each do
        get :index
      end
      
      it("responds ok") { response.should be_ok }
      it("assigns @issues") { assigns(:issues).should == [@my_issue12, @other_issue12] }
      
    end # Index End

    describe "show" do
      before(:each) { get :show, {:id => @other_issue12.id} }
      
      it("responds ok") { response.should be_ok }
      it("assigns @issue") { assigns(:issue).should == @other_issue12 }
    end #show   
    
    describe "new" do
      before(:each) { get :new }
      
      it("responds ok") { response.should be_ok }
      it("assigns @issue") { assigns(:issue).should == Issue.new }
    end #new 
    
    describe "edit" do
      
      before(:each) { get :edit, {:id => @other_issue12.id} }
      it("responds ok") { response.should be_ok }
      it("assigns @issue") { assigns(:issue).should == @other_issue12}
      
    end # Edit End
    
    describe "create" do
      before :all do
        @valid_issue_params12 = {:title => "abc", :issue_content =>"Issue Content",:user_id => @other.id}
      end
      before (:each)  { post :create, {:issue => @valid_issue_params12} }
      
      it("assigns @issue") { assigns(:issue).should be_a Issue }
      it("adds an issue") { expect {post :create, {:issue => @valid_issue_params12} }.to change(Issue, :count).by(1)}
      it("redirects to new issue") { response.should redirect_to(issue_path(assigns(:issue))) }
    end #create  
    
    describe "update" do
      before :all do
        @valid_issue_params123 = {:title => "abc", :issue_content =>"Issue Content",:user_id => @other.id}
      end
      
      before(:each) {  put :update, {:id => @other_issue12.id, :issue => @valid_issue_params123} }
      
      it("responds to issue ") { response.should redirect_to (@other_issue12) }
      it("assigns @issue") { assigns(:issue).should == @other_issue12 }
    end #update  
    
    
    describe "destroy" do
      before :each do
        @other_issue123 = FactoryGirl.create(:issue, :user_id => @other.id)
      end
      it("assigns @issue") do
        delete :destroy, {:id => @other_issue123.id }
        assigns(:issue).id.should == @other_issue123.id
      end
      it("destroy an issue") {  expect {delete :destroy, {:id => @other_issue123.id}}.to change(Issue, :count).by(-1)}
      it("redirects to issue") {
        delete :destroy, {:id => @other_issue123.id }
        response.should redirect_to(issues_url)
      }
      
    end # destroy
  end # Admin End
  
  
end# IssueController        






