# frozen_string_literal: true

# admin homepage page object definition
class AdminHomepagePage
  include Capybara::DSL

  def click_films_link
    click_link(films_link, match: :first)
  end

  private

  def films_link
    'films'
  end
end
