Given /^a user with email "(.*?)" and password "(.*?)"$/ do |email, password|
  FactoryGirl.create(:user, :email => email, :password => password, :password_confirmation => password)
end


Given /^I am not logged in$/ do

end


Given /^a logged in user$/ do
  @u = FactoryGirl.create(:user)
  visit new_user_session_path
  fill_in('user_email', :with => @u.email) 
  fill_in('user_password', :with => "password")
  click_on 'Sign in'
end


Given /^I am logged in as "(.*?)" with password "(.*?)"$/ do |email, password|
  visit new_user_session_path
  fill_in('user_email', :with => email) 
  fill_in('user_password', :with => password)
  click_on 'Sign in'
end
