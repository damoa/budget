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
end
