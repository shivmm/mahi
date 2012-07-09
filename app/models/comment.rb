# Comment class defines the comments raised for an issue
# Defines the data model for the class

class Comment

  include DataMapper::Resource

  property :id,         Serial
  property :created_at, DateTime
  property :body_comments, Text, :required =>true
  property :location, String, :required => true

# Comment belongs to a specific issue resembling to it
  belongs_to :issue
  belongs_to :user
end

