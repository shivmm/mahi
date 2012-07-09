require 'spec_helper'

describe Issue do
  
  it { should have_property(:title).of_type(DataMapper::Property::String)}
  it { should have_property(:issue_content).of_type(DataMapper::Property::Text)}
  it { should have_property(:created_at).of_type(DataMapper::Property::DateTime)}
 
  it { should belong_to(:user)}
  

  it{ should validate_presence_of(:title)}
  it{ should validate_presence_of(:issue_content)}
 # it{ should validate_presence_of(:submitted_by)}
  

end
