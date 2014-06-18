require 'rails_helper'

feature "user views a TV show's details", %Q{
  As a site visitor
  I want to view the details for a TV show
  So I can learn more about it
  I can see a the show's title, network, the years it ran, and a synopsis.
  For each character, I can see the character's name, actor's name, and the character's description
} do

  # Acceptance Criteria:
  # * I can see a the show's title, network, the years it ran,
  # and a synopsis.

  scenario "user views a TV show's details with characters" do
    show = TelevisionShow.create(title: 'Game of Thrones',
      network: 'HBO' )

    characters_show = [
      {chrarcter: 'Eddard Stark', actor: 'Sean Bean', description: 'Hand of the King, Lord of Winterfell, Warden of the North'},
      {character: 'Tywin Lanister', actor:'Charles Dance', description: 'Hand of the King, Lord of Casterly Rock, Warden of the West'}
    ]

    visit "/television_shows/#{show.id}"

    expect(page).to have_content show.title
    expect(page).to have_content show.network
    expect(page).to have_content show.years
    expect(page).to have_content show.synopsis

    characters_show.each do |character|
      expect(page).to have_content character[:character]
      expect(page).to have_content character[:actor]
      expect(page).to have_content character[:description]
    end
  end
end
