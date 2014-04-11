# Comment class defines the comments raised for an issue
# Defines the data model for the class

class Comment

  include DataMapper::Resource

  after :create, :update_issue_comment_count

  property :id,         Serial
  property :created_at, DateTime
  property :body_comments, Text, :required =>true
  property :location, String, :required => true
 property :state, String, :required => true
  belongs_to :issue
  belongs_to :user


  # Private: updates the cached comment count on the parent issue
  def update_issue_comment_count
    self.issue.update_comment_count
  end

end

