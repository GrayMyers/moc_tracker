require "rails_helper"

describe "User login" do
  describe "happy path" do
    it "allows users to login" do
      user = User.create(email: "funbucket123@example.com", password: "test")

      visit root_path

      click_link "I have an account"

      expect(current_path).to eq(login_path)

      fill_in :email, with: user.email
      fill_in :password, with: user.password

      click_button "Log In"

      expect(current_path).to eq(root_path)
      expect(page).to have_content("Welcome, #{user.email}")
    end
  end

  describe "sad path" do
    it "blocks login if bad credentials" do
      user = User.create(email: "funbucket123@example.com", password: "test")

      visit root_path

      click_link "I have an account"

      expect(current_path).to eq(login_path)

      fill_in :email, with: user.email.upcase
      fill_in :password, with: "not my password :("

      click_button "Log In"

      expect(current_path).to eq(login_path)
      expect(page).to have_content("I am pretty sure that isn't your account")
    end
  end
end
