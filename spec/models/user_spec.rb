require 'spec_helper'

describe User do
#  pending "add some examples to (or delete) #{__FILE__}"
  it { should have_property(:email)}
  it { should have_property(:role) }
  it { should validate_inclusion_of(:role).within([:user, :admin])}
  
  describe "admin" do
    it "should recognise admin properly" do
      User.new.admin?.should == false
      User.new(:role => :admin).admin?.should == true
    end
  end  
  
end
