# require './tumblr_watir.rb'

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
      expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

    config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups

  config.before(:all) do
    @b = Watir::Browser.new :chrome
  end

  config.after(:all) do
    @b.close
  end

end


def login_valid(username, password)
  @b.goto "https://www.tumblr.com"
  @b.button(id: "signup_login_button").click

  @b.text_field(id: "signup_determine_email").send_keys "#{username}"
  @b.button(id: "signup_forms_submit").click
  @b.element(id: "login-signin").click

  @b.text_field(id: "login-passwd").send_keys "#{password}"
  @b.button(id: "login-signin").click
  # Sometimes there's a popup and Watir can't find the element. 
  # !!modal.link(text: 'Got it').click
  @b.element(id: 'new_post_label_text').wait_until_present
end

def user_invalid(username, password)
  @b.goto "https://www.tumblr.com"
  @b.button(id: "signup_login_button").click
  @b.text_field(id: "signup_determine_email").send_keys "#{username}"
  @b.button(id: "signup_forms_submit").click
end

def is_logged_in?
  @b.button(title: "Account").click
  @b.element(id: "logout_button").wait_until_present.exists?
end 

def unregistered_email?
  @b.element(class: "error").wait_until_present.text.include?("This email doesn't have a Tumblr account.")
end

def invalid_email?
  @b.element(class: "error").wait_until_present.text.include?("That's not a valid email address. Please try again.")
end

def text_post(title, content)
  @b.element(id: 'new_post_label_text').click
  @b.div(class: "editor-richtext").send_keys "#{content}"
  @b.div(class: "editor-plaintext").send_keys "#{title}" 
  @b.element(css: "button.button-area.create_post_button").click
  @b.div(class: "post_title").wait_until_present.text.include?("#{title}")
end

def check_text?(title)
  @b.button(title: "Account").click
  @b.div(class: 'blog-sub-nav-item-label').click
  @b.div(class: "post_title").wait_until_present.text.include?("#{title}")
end

def image_post(url)
  @b.element(id: 'new_post_label_photo').click
  @b.element(css: 'div.split-cell.media-url-button').click
  @b.element(css: 'div.editor.editor-plaintext').click
  @b.element(css: 'div.editor.editor-plaintext').send_keys("#{url}\n")
  binding.pry
  @b.element(tag_name: img).attribute_value("src").text.include?("#{url}")
  @b.element(css: "button.button-area.create_post_button").click
end

def check_image?(url)
  @b.button(title: "Account").click
  @b.div(class: 'blog-sub-nav-item-label').click
  @b.img(class: "post_media_photo").wait_until_present
end












