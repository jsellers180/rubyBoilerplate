# frozen_string_literal: true

# admin members page object definition
class AdminMembersPage
  include Capybara::DSL

  def fill_search(email)
    fill_in search_fld.to_s, with: email
  end

  def click_go_btn
    click_button(go_btn, wait: 9000)
  end

  def open_details
    click_link(details_link, match: :first)
  end

  def click_members_link
    click_link(members_link, match: :first)
  end

  private

  def go_btn
    'go'
  end

  def search_fld
    'query'
  end

  def details_link
    'details'
  end

  def members_link
    'members'
  end
end
