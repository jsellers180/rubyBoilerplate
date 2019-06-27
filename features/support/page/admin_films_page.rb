# frozen_string_literal: true

# admin Films page object definition
class AdminFilmsPage
  include Capybara::DSL

  def click_first_result
    click_link(first_search_result, match: :first)
  end

  def search_films(film_name)
    fill_in(film_search_field, with: film_name)
  end

  def film_search_field
    '#film_filter'
  end

  def first_search_result
    '#ui-id-1'
  end
end
