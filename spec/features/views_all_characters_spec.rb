require 'rails_helper'

feature 'user views list of characters', %Q{
  As a site visitor
  I want to view a list of people's favorite TV characters
  So I can find wonky characters to watch
} do

  # Acceptance Criteria:
  # * I can see a list of all the characters

  scenario 'user views characters' do
    shows = []
    show_attrs = [
      { title: 'Game of Thrones', network: 'HBO' },
      { title: 'Orphan Black', network: 'BBC America' }
    ]

    show_attrs.each do |attrs|
      shows << TelevisionShow.create(attrs)
    end

    characters_show = [
      {chrarcter: 'Eddard Stark', actor: 'Sean Bean'},
      {character: 'Tywin Lanister', actor:'Charles Dance'}
    ]

    all_characters = []

    show = shows[0]
    characters_show.each do |character|
      character[:show] = show[:title]
      all_characters << character
      visit '/television_shows/#{show.id}'
      fill_in 'Character', with: character.name
      fill_in 'Actor', with: character.actor
      click_on 'Submit'
    end

    characters_show = [
      {chrarcter: 'Sarah Manning', actor:'Tatiana Maslany'},
      {character: 'Felix Dawkins', actor:'Jordan Gavaris'}
    ]
    show = shows[1]
    characters_show.each do |character|
      character[:show] = show[:title]
      all_characters << character
      visit '/television_shows/#{show.id}'
      fill_in 'Character', with: character.name
      fill_in 'Actor', with: character.actor
      click_on 'Submit'
    end




    visit '/characters'
    all_characters.each do |character|
      expect(page).to have_content character[:chracter]
      expect(page).to have_content character[:actor]
      expect(page).to have_content character[:show]
    end
  end
end


