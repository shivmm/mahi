require 'spec_helper'

describe Comment do
#  pending "add some examples to (or delete) #{__FILE__}"

  it { should have_property(:name).of_type(DataMapper::Property::String)}
  it { should have_property(:email).of_type(DataMapper::Property::String)}
  it { should have_property(:comment_time).of_type(DataMapper::Property::DateTime)}
  it { should have_property(:body_comments).of_type(DataMapper::Property::Text)}
  it { should belong_to(:issue)}

  it{ should validate_presence_of(:name)}
  it{ should validate_presence_of(:comment_time)}
  it{ should validate_presence_of(:body_comments)}
  
  it { should validate_format_of(:email).with(:email_address)}

end
