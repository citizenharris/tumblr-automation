require "watir"
require "dotenv"
require "pry"

describe "Tumblr automated tests" do

  it "shouldn't allow a user to login with an unregistered email" do
    user_invalid('xxxxxxxxxx@emailz.com', 'password')
    expect(unregistered_email?).to eq true
  end

  it "shouldn't allow a user to login with invalid email format" do
    user_invalid('fhewailfloaw', 'password')
    expect(invalid_email?).to eq true
  end

  it "should allow user to login with valid details" do
    login_valid('gharris@spartaglobal.co', 'foobar123')
    expect(is_logged_in?).to eq true
    puts "Logged in, yo!"
  end

  it "should allow a user to post text" do
    login_valid('gharris@spartaglobal.co', 'foobar123') 
    text_post("Title Time!", "Here's some interesting content")
    expect(check_text?("Title Time!")).to eq true
  end

  it 'should allow a user to post an image' do
    login_valid('gharris@spartaglobal.co', 'foobar123') 
    image_post('http://i.imgur.com/OLmQCe7.jpg')
    expect(check_image?('http://i.imgur.com/OLmQCe7.jpg')).to eq true
  end
end

# 'gharris@spartaglobal.co'
# 'foobar123'
# 'http://i.imgur.com/OLmQCe7.jpg '