When /^I visit the login page$/ do
  visit new_user_session_path
end

When /^I fill in "(.*?)" with "(.*?)"$/ do |id, value|
  fill_in id, :with => value
end


When /^I visit the home page$/ do
  visit root_url
end

When /^I visit "(.*?)"$/ do |url|
  visit url
end


When /^I click on "(.*?)"$/ do |element|
  click_on element
end

Then /^I should see "(.*?)"$/ do |text|
  page.should have_content(text)
end

Then /^I should not see "(.*?)"$/ do |text|
  page.should_not have_content(text)
end

Then /^I should have (\d+) "(.*?)" selector$/ do |num, selector|
  page.all(selector).count.should == num.to_i
end




When /^I visit any page$/ do
  visit root_url
end
