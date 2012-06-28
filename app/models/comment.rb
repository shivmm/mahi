# Comment class defines the comments raised for an issue
# Defines the data model for the class

class Comment

  include DataMapper::Resource

  property :id,         Serial
  property :name,       String,   :required =>true
  property :email,      String,   :format => :email_address
  property :comment_time, DateTime, :required =>true
  property :body_comments, Text, :required =>true
  property :location, String, :required => true

# Comment belongs to a specific issue resembling to it
  belongs_to :issue
end

