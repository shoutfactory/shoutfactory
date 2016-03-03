Given(/^I navigate on \[Home\] page$/) do
  @shoutfactory = Shoutfactory.new
  visit "#{EnvConfig.get :shoutfactory_url}"
end

When(/^I click on '(.*)' tab$/) do |tab|
  @shoutfactory.home_page.header_tab(tab).click
end

When(/^I fill sign up form with following data:$/) do |table|

    table.hashes.each do |field|
      name = field[:name]
      email = field[:email]
      password = field[:password]
      confirm_password = field[:confirm_password]


      @shoutfactory.home_page.sign_up_field('Name').set unique_value(name) if name
      @shoutfactory.home_page.sign_up_field('Email').set unique_email(email) if email
      @shoutfactory.home_page.sign_up_field('Password').set unique_value(password) if password
      @shoutfactory.home_page.sign_up_field('CPassword').set unique_value(confirm_password) if confirm_password

      @shoutfactory.home_page.submit_button.click

      wait_until{ @shoutfactory.home_page.registering_as('Trainer').visible? == true}
    end
end

When(/^I registering as '(.*)'$/) do |user|
  @shoutfactory.home_page.registering_as(unique_value(user)).click
end

Then(/^I should see '(.*)' user's page$/) do |user|
  expect(@shoutfactory.home_page.header_tab(unique_value(user)).visible?).to be_truthy
end

