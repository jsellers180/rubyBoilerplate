# frozen_string_literal: true

require 'faker'
require 'luhnacy'
require 'time'

# class containing methods to generate cc info
class CcClient
  # Generates a "valid" credit card using the luhnacy algorithm.
  # Will only work on staging and below.
  def cc_num
    Luhnacy.generate(16, prefix: '53')
  end

  # Generates a random valid zip code
  # We are using random 5 digits here instead of the address library
  # because there is no way to limit the zip to 5 digits
  def zip_code
    Faker::Number.number(5)
  end

  # generates a random 3 digit number
  def cvn
    Faker::Number.number(3)
  end

  # Generates a random first and last name combo
  def full_name
    Faker::Name.name
  end

  # Generates a random month value. Then adds a leading 0 if the value is <10
  def exp_month
    month = Faker::Number.between(01, 12)
    format('%2.2d', month)
  end

  # Generates a random valid year
  def exp_year
    Faker::Number.between(2019, 2032)
  end

  def invalid_cc
    '1111111111111111'
  end
end
