namespace :transactions do
  desc 'A task to fill transaction category column with respective values'
    task 'fill_category' => :environment do
      
      Transaction.all.each do |transaction|
        transaction.set_category
    end
  end
end
