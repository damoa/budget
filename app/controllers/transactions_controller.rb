class TransactionsController < ApplicationController
  def index
    @transactions = Transaction.all
  end

  def daily_min
    @transactions = Transaction.daily_min
    
    respond_to do |format|
      format.html
      format.json {render :json => @transactions.map { |t| [t.value_date_in_milliseconds, t.amount, t.balance]}}
    end
  end

  def monthly
    @transactions = Transaction.monthly_sum.all
    respond_to do |format|
      format.html
      format.json {render :json => @transactions.map { |t| [t.value_date, t.amount]}}
    end
  end

  def monthly_withdrawal
    @transactions = Transactions::Withdrawal.monthly_sum.all
    respond_to do |format|
      format.html
      format.json {render :json => @transactions.map { |t| [t.value_date, t.amount]}}
    end
  end

  def overall
    @transactions = Transaction.by_type.all
    respond_to do |format|
      format.html
      format.json {render :json => @transactions.map { |t| [t.type, t.amount]}}
    end
  end
end
