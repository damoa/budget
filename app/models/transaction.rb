class Transaction < ActiveRecord::Base
  attr_accessible :booking_date, :value_date, :type, :details, :originator,
    :receiver, :amount, :balance

  scope :daily_min, select("value_date AS value_date, sum(amount) AS amount, MIN(balance) AS balance")
    .group("value_date")
    .order("value_date")
  
  TYPE_MAPPING = {
    'Lastschrift' => 'Transactions::Charge',
    'Dauerauftrag' => 'Transactions::AutomaticBillPayment',
    'Zinsen/Entgelt' => 'Transactions::Interest',
    'Kartenverfügung' => 'Transactions::Withdrawal',
    'Überweisung' => 'Transactions::MoneyTransfer',
    'Gutschrift' => 'Transactions::CreditEntry'
  }
  
  def booking_date_in_milliseconds
    booking_date.to_time.to_i * 1000
  end
  
  def value_date_in_milliseconds
    value_date.to_time.to_i * 1000
  end
end
