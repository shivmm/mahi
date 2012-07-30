When /^I visit the login page$/ do
  visit new_user_session_path
end

When /^I fill in "(.*?)" with "(.*?)"$/ do |id, value|
  fill_in id, :with => value
end


When /^i visit the home page$/ do
  visit root_url
end

When /^I click on "(.*?)"$/ do |element|
  click_on element
end

Then /^I should see "(.*?)"$/ do |text|
  page.should have_content(text)
end


When /^I visit any page$/ do
  visit root_url
end
