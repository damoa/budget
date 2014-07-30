class TransactionsController < ApplicationController
  def index
    @transactions = Transaction.all
  end

  def daily_min
    @transactions = Transaction.daily_min
    
    respond_to do |format|
      format.json {render :json => @transactions.map { |t| [t.value_date_in_milliseconds, t.amount, t.balance]}}
    end
  end
end
