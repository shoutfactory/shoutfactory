module CapybaraHelper

  require 'rubygems'
  require 'active_support/core_ext/numeric/time'

  def wait_until
    require "timeout"
    Timeout.timeout(Capybara.default_wait_time) do
      sleep(0.1) until value = yield
      value
    end
  end

  def element_visible?(xpath_locator)
    element_present?(xpath_locator) && element_displayed?(xpath_locator)
  end

  def element_present?(xpath_locator)
    page.has_xpath?(xpath_locator)
  end

  def element_displayed?(xpath_locator)
    find(:xpath, xpath_locator).visible?
  end

  def unique_email(email)
    if email == ""
      return ""
    elsif email.include? "pre-setup"
      return email.gsub("pre-setup ", "")
    end
    email = email.split('@')
    "#{email.first}#{@random_string}@#{email.last}"
  end

  def unique_value(value)
    if value.include? "pre-setup"
      value.gsub("pre-setup ", "")
    elsif value == ""
      ""
    else
      value + @random_string
    end
  end

end

