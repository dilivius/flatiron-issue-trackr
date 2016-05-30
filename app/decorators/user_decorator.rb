class UserDecorator < SimpleDelegator

  def display_phone_number
    phone_number && !phone_number.empty? ? phone_number : "<i>add your phone number to receive text message updates</i>".html_safe
  end
end