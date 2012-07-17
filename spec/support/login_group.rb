shared_examples_for "make_users" do
  before :all do
    @u = FactoryGirl.create(:user)
    @o = FactoryGirl.create(:user)
    
  end
end


shared_examples_for "logged_in" do
  
  before(:each) do 
    @request.env["devise.mapping"] = Devise.mappings[:user]
    sign_in @u
  end
end

