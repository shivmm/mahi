Given /^some data$/ do
  steps %{
    Given an empty database
    And a user with email "abc@def.com" and password "foobar"
    And a user with email "other@mahi.com" and password "foobar"
    And a admin with email "superadmin@mahi.com" and password "foobar"
    And an issue for user "abc@def.com"
    And an issue for user "other@mahi.com"
  }
end
