# Class Issue defines the properties of the issues raised by the end user e.g open bore wells
# Specifies the data model for the issues
# Define number of properties for Issue

class Issue

  include DataMapper::Resource

  property :id,             Serial
  property :title,          String, :required => true
  property :issue_content,  Text, :required => true
  property :created_at,     DateTime

  property :comment_count, Integer, :default => 0

  # Association defined for comments
  has n, :comments

  belongs_to :user

  # Public: Updates the comment count
  def update_comment_count
    self.comment_count = self.comments.count
    self.save!
  end

end
