require 'rails_helper'

RSpec.describe 'Applications new page', type: :feature do
  it 'creates new application' do
    visit "/applications/new"

    within("#application-new") do
      fill_in("Name", with: "Katie Molland")
      fill_in("Street Address", with: "664 S Lowell Ave.")
      fill_in("City", with: "Denver")
      fill_in("State", with: "Colorado")
      fill_in("Zip Code", with: "80227")
      click_on "Submit"
    end

    expect(page).to have_content("Katie Molland")
    expect(page).to have_content("664 S Lowell Ave. Denver, Colorado 80227")
    expect(page).to have_content("In Progress")
  end

  it 'cannot create an application without all applicant info' do
    visit "/applications/new"

    click_on "Submit"

    expect(current_path).to eq("/applications/new")
    expect(page).to have_content("Application not created: Required information missing.")
    expect(page).to have_button("Submit")
  end
end
