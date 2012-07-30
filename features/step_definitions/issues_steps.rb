Given /^there are no issues$/ do
  Comment.all.destroy!
  Issue.all.destroy!
end

Given /^an empty database$/ do
  Comment.all.destroy!
  Issue.all.destroy!
  User.all.destroy!
end

Given /^I add (\d+) issues with (\d+) comments and title "(.*?)"$/ do |num_issues, num_comments, issue_titles|
  issue_titles = issue_titles.split(",")
  num_issues = num_issues.to_i
  num_comments = num_comments.to_i
  raise ArgumentError.new("wrong amount of titles") if issue_titles.count != num_issues
  @comment_user = FactoryGirl.create(:user)
  issue_titles.each do |title|
    issue = FactoryGirl.create(:issue, :title => title.strip)
    num_comments.times do |i|
      c = Comment.new(:location => "defghi", :body_comments => "comment #{i} on issue #{issue.id}", :issue_id => issue.id, :user_id => @comment_user.id)
      c.save
    end
  end
end

Given /^an issue for user "(.*?)" with password "(.*?)"$/ do |email, password|
  @user = FactoryGirl.create(:user, :email => email, :password => password, :password_confirmation => password)
  @my_issue = FactoryGirl.build(:issue, :user => @user)
  @my_issue.save!
end



Then /^i should see the following issues:$/ do |table|
  # table is a Cucumber::Ast::Table
  page.find('table#issues_index').find('tbody').all('tr').map{|tr| tr.text.split("\n")[1]}.should == table.rows.flatten
end


When /^I visit the new issue page$/ do
  visit new_issue_path
end

When /^I try to edit that issue$/ do
  visit edit_issue_path(@my_issue)
end
