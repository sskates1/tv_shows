require 'rails_helper'

feature "user views a TV show's details", %Q{
  As a site visitor
  I want to delete a character I don't like
  So no one else will want to watch that character
  * I can delete a character from the database
  * If the record is successfully deleted, I receive an notice that it was deleted
} do

  # Acceptance Criteria:
  # * I can see a the show's title, network, the years it ran,
  # and a synopsis.

  scenario "user deletes a chracter from a show" do
    show = TelevisionShow.create(title: 'Game of Thrones',
      network: 'HBO' )

    visit "/television_shows/#{show.id}"

    click_on 'Delete'

    character = {chrarcter: 'Eddard Stark', actor: 'Sean Bean'}

    expect(page).to_not have_content character[:character]
    expect(page).to_not have_content character[:actor]

  end
end
