# frozen_string_literal: true

# Account page object definition
class AccountPage
  include Capybara::DSL

  # Membership tab
  def click_membership_tab
    click('Membership')
  end

  def email_field
    'email'
  end

  def fname_field
    'first-name'
  end

  def lname_field
    'last-name'
  end

  def cancel_sub_link
    'btn-cancel'
  end

  def loading_screen
    'Updating Account Settings'
  end

  def renew_btn
    'Renew Now'
  end

  def cancel_msg
    'YOUR SUBSCRIPTION HAS BEEN CANCELLED'
  end

  def updating_msg
    'Updating Account Settings'
  end

  def member_update_success
    'Your changes have been saved.'
  end

  # Devices Tab
  def click_devices_tab
    click('Devices')
  end

  def activation_code_fld
    'deviceCode'
  end

  def device_name_fld
    'deviceName'
  end

  def activate_btn
    'Activate'
  end

  def click_activate_btn
    click_button(activate_btn)
  end

  # Password tab
  def click_password_tab
    click('Password')
  end

  def current_password_fld
    'current_password'
  end

  def new_password_fld
    'new_password'
  end

  def confirm_password_fld
    'confirm_password'
  end

  def update_btn
    'Update'
  end

  def click_update_btn
    click_button(update_btn)
  end

  # payment tab
  def name_on_card_fld
    'vin_PaymentMethod_accountHolderName'
  end

  def ccn_fld
    'vin_PaymentMethod_creditCard_account'
  end

  def zip_fld
    'vin_PaymentMethod_billingAddress_postalCode'
  end

  def cvn_fld
    'vin_PaymentMethod_nameValues_cvn'
  end

  def month_dropdown
    'vin_PaymentMethod_creditCard_expirationDate_Month'
  end

  def year_dropdown
    'vin_PaymentMethod_creditCard_expirationDate_Year'
  end

  def payment_update_success
    'You have successfully updated your billing information.'
  end
end
