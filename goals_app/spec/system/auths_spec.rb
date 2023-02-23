require 'rails_helper'

RSpec.describe "Auths", type: :system do

    before do
      driven_by(:rack_test)
    end

    describe "the sign up process" do

        before do
            visit new_user_path
        end

        it "has a new user page" do
            expect(page).to have_content("New User")
        end

        it "shows username on the homepage after signup" do
            fill_in "Username", with: "Edbassmaster"
            fill_in "Password", with: "ilikefishing"
            click_button "Create User"
            expect(page).to have_content("Edbassmaster")
        end

    end # Ends the sign up process

    describe "logging in" do
        it "shows username on the homepage after login" do
            user = User.create(username: "JamesMurray", password: "Veronica")
            visit login_path
            fill_in "Username", with: user.username
            fill_in "Password", with: user.password
            click_button "Log in"
            expect(page).to have_content("JamesMurray")
        end
    end

    describe "logging out" do
        it "begins with a logged out state" do
            visit root_path
            expect(page).not_to have_content('Log out')
        end
        it "doesn't show username on the homepage after logout" do
            user = User.create(username: 'test_user', password: 'password')
            visit login_path
            fill_in 'Username', with: 'test_user'
            fill_in 'Password', with: 'password'
            click_button 'Log in'
            click_link 'Log out'
            expect(page).not_to have_content('test_user')
        end
    end
end