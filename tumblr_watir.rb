require "watir"
require "dotenv"
require "pry"

class Tumblr
  def initialize
    @b = Watir::Browser.new
  end

  def login 
    @b.goto "tumblr.com"
    @b.button(id: "signup_login_button").click

    @b.text_field(id: "signup_determine_email").set 'gharris@spartaglobal.co'
    @b.button(id: "signup_forms_submit").click
    @b.element(id: "login-signin").click

    @b.text_field(id: "login-passwd").set('foobar123')
    @b.button(id: "login-signin").click
    @b.element(id: 'new_post_label_text').wait_until_present
  end

  def text_post(title:, content:)
    @b.element(id: 'new_post_label_text').click

    @b.div(class: "editor-richtext").send_keys "#{content}"

    @b.div(class: "editor-plaintext").send_keys "#{title}" 

    @b.element(css: "button.button-area.create_post_button").click

    @b.div(class: "post_title").wait_until_present.text.include?("#{title}")

  end




a = Tumblr.new
a.login
binding.pry

a.text_post(title: "thing", content: "hello")

end


# b.element(id: 'new_post_label_text').click.wait_until_present

# b.element(css: 'div.editor.editor-richtext').set('')

# title = browser.find_element css: 'div.editor.editor-plaintext'
# title.click
# title.send_keys 'Thoughts of a robot'

# post_btn = browser.find_element css: 'button.button-area.create_post_button'
# post_btn.click
