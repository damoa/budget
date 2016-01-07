class Transaction < ActiveRecord::Base

  CATEGORY_REGEXPS = YAML.load_file( File.join( Rails.root, 'config', 'private', 'regexp.yml'))['regexp']
  FITNESS = eval CATEGORY_REGEXPS['fitness']
  PUBLIC_TRANSPORTATION = eval CATEGORY_REGEXPS['public_transportation']
  CHILDREN = eval CATEGORY_REGEXPS['children']
  LIFE_INSURANCE = eval CATEGORY_REGEXPS['life_insurance']
  FURTHER_INSURANCE = eval CATEGORY_REGEXPS['further_insurance']
  RENT = eval CATEGORY_REGEXPS['rent']
  OTTO = eval CATEGORY_REGEXPS['otto']
  PHONE = eval CATEGORY_REGEXPS['phone']
  STUDENT_LOAN = eval CATEGORY_REGEXPS['student_loan']
  CHILD_SAVINGS = eval CATEGORY_REGEXPS['child_savings']
  
  TYPE_MAPPING = {
    'Lastschrift'     => 'Transactions::Charge',
    'Dauerauftrag'    => 'Transactions::AutomaticBillPayment',
    'Zinsen/Entgelt'  => 'Transactions::Interest',
    'Kartenverfügung' => 'Transactions::Withdrawal',
    'Überweisung'     => 'Transactions::MoneyTransfer',
    'Gutschrift'      => 'Transactions::CreditEntry',
    'Gehalt/Rente'    => 'Transactions::Salary',
    'Storno'          => 'Transactions::Reversal',
    'Auszahlung'      => 'Transactions::Payout',
    'Einzahlung'      => 'Transactions::Deposit'
  }

  attr_accessible :booking_date, :value_date, :category, :type, :details, :originator,
    :receiver, :amount, :balance

  scope :daily_min, select("value_date AS value_date, sum(amount) AS amount, MIN(balance) AS balance")
    .group("value_date")
    .order("value_date")

  scope :monthly_sum, select("MAX(value_date) AS value_date, sum(amount) AS amount")
    .group("strftime('%Y-%m', value_date)")
    .order("strftime('%Y-%m', value_date)")

  scope :by_type, select("type, sum(amount) AS amount")
    .group("type")
    .order("type")
  
  def set_category
    case details
    when FITNESS
      update_attributes(category: 'Fitness')
    when PUBLIC_TRANSPORTATION
      update_attributes(category: 'Public Transportation')
    when CHILDREN
      update_attributes(category: 'Children')
    when LIFE_INSURANCE
      update_attributes(category: 'Life Insurance')
    when FURTHER_INSURANCE
      update_attributes(category: 'Further Insurances')
    when RENT
      update_attributes(category: 'Rent')
    when OTTO
      update_attributes(category: 'Otto')
    when PHONE
      update_attributes(category: 'Phone')
    when STUDENT_LOAN
      update_attributes(category: 'Student Loan')
    when CHILD_SAVINGS
      update_attributes(category: 'Child Savings')
    end
  end

  def booking_date_in_milliseconds
    booking_date.to_time.to_i * 1000
  end
  
  def value_date_in_milliseconds
    value_date.to_time.to_i * 1000
  end
end
