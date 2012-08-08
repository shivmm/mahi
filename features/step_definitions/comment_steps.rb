When /^a user with email "(.*?)" Create a comment on an issue of email "(.*?)"$/ do |email1, email2|
  user = FactoryGirl.create(:user, :email => email1)
  issue_user = FactoryGirl.create(:user, :email => email2)
  my_issue = issue_user.issues.first
  FactoryGirl.create(:comment, :user =>user, :issue => my_issue)   
end

Given /^a comment on an issue for user "(.*?)"$/ do |email|
  user =  User.first(:email => email)
  my_comment =  FactoryGirl.create(:comment, :user_id => user.id, :issue_id => user.issues.first.id )
end

