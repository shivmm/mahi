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


shared_examples_for "admin_role" do
  
  before(:all) do
    @as_admin = FactoryGirl.create(:user, :role => "admin")
  end
  
  before(:each) do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    sign_in @as_admin
  end
end

