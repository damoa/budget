class Transaction < ActiveRecord::Base
  attr_accessible :booking_date, :value_date, :type, :details, :originator,
    :receiver, :amount, :balance
  
  TYPE_MAPPING = {
    'Lastschrift' => 'Transactions::Charge',
    'Dauerauftrag' => 'Transactions::AutomaticBillPayment',
    'Zinsen/Entgelt' => 'Transactions::Interest',
    'Kartenverfügung' => 'Transactions::Withdrawal',
    'Überweisung' => 'Transactions::MoneyTransfer',
    'Gutschrift' => 'Transactions::CreditEntry'
  }
end
