# User class holds the general properties of authorized users for posting comments in an issue
# Describes the data model for the user information like his email_id, password etc.
# Property email hold feature of uniqness

class User

  include DataMapper::Resource

  property :id,          Serial
  property :firstname,   String, :required => true
  property :lastname,    String, :required => true
  property :password,    String, :required => true
  property :email,       String, :required => true, :format => :email_address, :unique => true
  property :created_at,   DateTime, :required => true
  

# Matcher is being used for password ranging
  validates_length_of :password, :min => 6, :max => 20
  
end
