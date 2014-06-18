require 'rails_helper'

feature 'user adds a new character to a TV show', %Q{
  As a site visitor
  I want to add my favorite TV show characters
  So that other people can enjoy their crazy antics
} do

  # Acceptance Criteria:
  # * I must provide the show's title.
  # * I can optionally provide the show's network, the years it ran,
  # and a synopsis.

  scenario 'user adds a new character to a TV show' do
    attrs = {
      title: 'Game of Thrones',
      network: 'HBO',
      years: '2011-',
      synopsis: 'Seven noble families fight for control of the mythical land of Westeros.'
    }

    show = TelevisionShow.new(attrs)

    visit '/television_shows/new'
    fill_in 'Title', with: show.title
    fill_in 'Network', with: show.network
    fill_in 'Years', with: show.years
    fill_in 'Synopsis', with: show.synopsis
    click_on 'Submit'

    char_attrs = {
      name: 'Eddard Stark',
      actor: 'Sean Bean',
      description: 'Hamd of the King,Lord of Winterfell, and Warden of the North'
    }

    character = Character.new(char_attrs)

    visit '/television_shows/#{show.id}'
    fill_in 'Character', with: character.name
    fill_in 'Actor', with: character.actor
    fill_in 'Description', with: character.description
    click_on 'Submit'

    expect(page).to have_content 'Success'
    expect(page).to have_content character.name
    expect(page).to have_content character.actor
    expect(page).to have_content character.description
  end

  scenario 'without required attributes' do
    visit '/television_shows/#{show.id}'
    click_on 'Submit'

    expect(page).to_not have_content 'Success'
    expect(page).to have_content "can't be blank"
  end

  scenario 'user cannot add a character that is already in the database' do
    char_attrs = {
      name: 'Eddard Stark',
      actor: 'Sean Bean'
    }

    character = Character.create(char_attrs)

    visit '/television_shows/#{show.id}'
    fill_in 'Character', with: character.name
    fill_in 'Actor', with: character.actor
    click_on 'Submit'

    expect(page).to_not have_content 'Success'
    expect(page).to have_content "has already been taken"
  end
end
