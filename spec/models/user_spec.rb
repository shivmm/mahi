require 'spec_helper'

describe User do
  #  pending "add some examples to (or delete) #{__FILE__}"
  
  it { should have_property(:firstname).of_type(DataMapper::Property::String)}
  it { should have_property(:lastname).of_type(DataMapper::Property::String)}
  it { should have_property(:password).of_type(DataMapper::Property::String)}
  it { should have_property(:email).of_type(DataMapper::Property::String)}
  it { should have_property(:created_at).of_type(DataMapper::Property::DateTime)}
  
  it{ should validate_presence_of(:firstname)}
  it{ should validate_presence_of(:lastname)}
  it{ should validate_presence_of(:created_at)}
  it{ should validate_presence_of(:password)}
  
  
  it { should validate_format_of(:email).with(:email_address)}

end
