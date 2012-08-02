# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


require File.join(Rails.root,'spec','factories.rb')

DataMapper.auto_migrate!

@admin = FactoryGirl.create(:user, :email => "admin@mahi.com")
@other = FactoryGirl.create(:user, :email => "other@mahi.com")
@super_admin = FactoryGirl.create(:user, :email => "superadmin@mahi.com", :role => "admin")
@first_issue = FactoryGirl.create(:issue, :user => @admin, :title => "admin issue")
@second_issue = FactoryGirl.create(:issue, :user => @other, :title => "other issue")

FactoryGirl.create(:comment, :user => @admin, :issue => @first_issue)
FactoryGirl.create(:comment, :user => @admin, :issue => @second_issue)

FactoryGirl.create(:comment, :user => @other, :issue => @first_issue)
FactoryGirl.create(:comment, :user => @other, :issue => @second_issue)
