# frozen_string_literal: true

# watchlist page object definition
class WLPage
  def remove_from_wl
    'Remove from Watchlist'
  end

  def add_to_wl
    'Add to Watchlist'
  end

  def header
    'MY WATCHLIST'
  end

  def film_css
    '.lazyloaded'
  end

  def empty_wl
    'Your Watchlist is currently empty. See what\'s new on Hallmark Movies Now and start adding titles now.'
  end
end
