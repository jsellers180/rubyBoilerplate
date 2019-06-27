# frozen_string_literal: true

# History page object definition
class HistoryPage
  include Capybara::DSL

  # message that displays when you nav to the history page and haven't watched anything
  def no_history_msg
    'Your History is currently empty. Check out our Featured Movies and start watching today.'
  end

  def list_view
    '.fa.fa-th-list'
  end

  def large_view
    '.fa.fa-th-large'
  end

  def click_list_view
    click(list_view)
  end

  def click_large_view
    click(large_view)
  end
end
