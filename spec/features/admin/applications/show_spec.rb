require 'rails_helper'

RSpec.describe 'Admin applications show page' do
  before(:each) do
    @shelter_1 = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @shelter_2 = Shelter.create!(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
    @shelter_3 = Shelter.create!(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)
    @pet_1 = Pet.create!(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true, shelter: @shelter_1)
    @pet_2 = Pet.create!(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true, shelter: @shelter_1)
    @pet_3 = Pet.create!(name: 'Lucille Bald', breed: 'sphynx', age: 8, adoptable: true, shelter: @shelter_2)
    @shelter_1.pets << @pet_1
    @shelter_1.pets << @pet_2
    @shelter_3.pets << @pet_3
    @app_1 = Application.create!(name: "Erika Kischuk", address: "455 Villa Ct. Morrison, CO 80228", description: "I love animals", status: "In Progress")
    @app_2 = Application.create!(name: "Kate Hill", address: "67 S Montgomery St. Lakewood, CO 80227", description: "Dogs love me!", status: "In Progress")
  end

  it 'shows application attributes and pets' do
    @app_1.pets << @pet_1
    @app_1.pets << @pet_2

    visit "/admin/applications/#{@app_1.id}"

    expect(page).to have_content(@app_1.name)
    expect(page).to have_content(@pet_2.name)
    expect(page).to_not have_content(@pet_3.name)
  end

  it 'has approve button for each pet' do
    @app_1.pets << @pet_1
    @app_1.pets << @pet_2

    visit "/admin/applications/#{@app_1.id}"

    within("#pet-#{@pet_1.id}") do
      expect(page).to have_button("Approve")
    end

    within("#pet-#{@pet_2.id}") do
      expect(page).to have_button("Approve")
      click_on "Approve"
    end

    expect(current_path).to eq("/admin/applications/#{@app_1.id}")

    within("#pet-#{@pet_1.id}") do
      expect(page).to have_button("Approve")
    end

    within("#pet-#{@pet_2.id}") do
      expect(page).to_not have_button("Approve")
      expect(page).to have_content("Approved")
    end
  end
  it 'has reject button for each pet' do
    @app_1.pets << @pet_1
    @app_1.pets << @pet_2

    visit "/admin/applications/#{@app_1.id}"

    within("#pet-#{@pet_1.id}") do
      expect(page).to have_button("Reject")
    end

    within("#pet-#{@pet_2.id}") do
      expect(page).to have_button("Reject")
      click_on "Reject"
    end

    expect(current_path).to eq("/admin/applications/#{@app_1.id}")

    within("#pet-#{@pet_1.id}") do
      expect(page).to have_button("Reject")
    end

    within("#pet-#{@pet_2.id}") do
      expect(page).to_not have_button("Reject")
      expect(page).to have_content("Rejected")
    end
  end

  it 'only updates one app at a time' do
    @app_1.pets << @pet_1
    @app_1.pets << @pet_2
    @app_2.pets << @pet_1
    @app_2.pets << @pet_2

    visit "/admin/applications/#{@app_1.id}"

    within("#pet-#{@pet_2.id}") do
      expect(page).to have_button("Reject")
      click_on "Reject"
    end
    within("#pet-#{@pet_2.id}") do
      expect(page).to_not have_button("Reject")
      expect(page).to have_content("Rejected")
      expect(page).to_not have_button("Accept")
      expect(page).to_not have_content("Accepted")
    end

    visit "/admin/applications/#{@app_2.id}"

    within("#pet-#{@pet_1.id}") do
      expect(page).to have_button("Approve")
      expect(page).to have_button("Reject")
    end

    within("#pet-#{@pet_2.id}") do
      expect(page).to have_button("Approve")
      expect(page).to have_button("Reject")
    end
  end
end
