# frozen_string_literal: true

require 'faker'
require_relative '../page/sign_up_page'

# common usage methods for user creation
class UserClient
  attr_reader :valid_email, :valid_password

  def test_time
    Time.now.to_i
  end

  # generates a random email
  def user_email
    @valid_email = [Faker::Internet.slug,
                    Time.now.to_i,
                    '@hallmarklabs.com'].join
  end

  # generates a random first name
  def user_fname
    Faker::Name.first_name
  end

  # generates a random last name
  def user_lname
    Faker::Name.last_name
  end

  # generates a random password with defaults between 10 and 20 chars.
  # Accepts args for less or more chars.
  def user_password(min = 10, max = 20)
    @valid_password = Faker::Internet.password(min, max).to_s
  end
end
