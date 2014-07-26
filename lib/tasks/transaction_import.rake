require 'csv'

namespace :transactions do
  desc 'A task to import POSTBANK transaction data CSVs'
  task 'postbank_csv_import' => :environment do
    
    file = File.open(ENV['IMPORT_FILE'], "r:ISO-8859-1")
    first_row = false
    CSV.parse(file, col_sep: ';') do |row|
      if !first_row && row == ["Buchungstag", "Wertstellung", "Umsatzart", "Buchungsdetails", "Auftraggeber", "Empfänger", "Betrag (\u0080)", "Saldo (\u0080)"]
        first_row = true
      elsif first_row
        booking_date = Date.strptime(row[0], "%d.%m.%Y")
        value_date = Date.strptime(row[1], "%d.%m.%Y")
        type = Transaction::TYPE_MAPPING[row[2]]
        amount = row[6].gsub('.','').gsub(',','.').to_f
        balance = row[7].gsub('.','').gsub(',','.').to_f
        begin
          Transaction.find_or_create_by_booking_date_and_value_date_and_type_and_details_and_receiver_and_amount_and_balance(booking_date: booking_date, value_date: value_date, type: type, details: row[3], originator: row[4], receiver: row[5], amount: amount, balance: balance)
        rescue Exception=>e
          p e
        end
      end
    end
  end
end
