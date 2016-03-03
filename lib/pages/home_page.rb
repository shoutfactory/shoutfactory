class HomePage < SitePrism::Page

  include CapybaraHelper

  element :submit_button, '[value=Submit]'

  def sign_up_field(name)
    find(:xpath, "//input[contains(@id,'#{name}')]")
  end

  def registering_as(name)
    find(:xpath, "//input[@value='#{name}']")
  end

  def header_tab(tab)
    find(:xpath, "//div[@class='nex_center']//span[text()='#{tab}']")
  end

end
