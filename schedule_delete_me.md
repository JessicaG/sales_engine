TODOS:
Spec Harness Failures
- most revenue and most items, revenue by date
- optimized
- Creating Invoices
-

Tuesday
Biz logic
fixing Spec

Wed
Refactoring

Thursday
Assess

Refactoring Ideas
- changing the file path from testing to user provided directory for all repos

Would be nice if time
- clean data

###################
  1) SalesEngine invoices Business Intelligence .create creates a new invoice
     Failure/Error: invoice = engine.invoice_repository.create(customer: customer, merchant: merchant, items: items)
     NoMethodError:
       undefined method `create' for #<InvoiceRepository 4843 rows>
     # ./spec/invoice_spec.rb:83:in `block (4 levels) in <top (required)>'

  2) SalesEngine invoices Business Intelligence #charge creates a transaction
     Failure/Error: invoice.charge(credit_card_number: '1111222233334444',  credit_card_expiration_date: "10/14", result: "success")
     NoMethodError:
       undefined method `charge' for #<Invoice:0x000001014be2e8>
     # ./spec/invoice_spec.rb:99:in `block (4 levels) in <top (required)>'

  3) SalesEngine items Business Intelligence #best_day returns something castable to date
     Failure/Error: best.include?(item.best_day.to_date).should be_true
     TypeError:
       String can't be coerced into Fixnum
     # /Users/jessicag/sales_engine/lib/item.rb:37:in `+'
     # /Users/jessicag/sales_engine/lib/item.rb:37:in `block (2 levels) in best_day'
     # /Users/jessicag/sales_engine/lib/item.rb:37:in `each'
     # /Users/jessicag/sales_engine/lib/item.rb:37:in `reduce'
     # /Users/jessicag/sales_engine/lib/item.rb:37:in `block in best_day'
     # /Users/jessicag/sales_engine/lib/item.rb:37:in `each_pair'
     # /Users/jessicag/sales_engine/lib/item.rb:37:in `each'
     # /Users/jessicag/sales_engine/lib/item.rb:37:in `map'
     # /Users/jessicag/sales_engine/lib/item.rb:37:in `best_day'
     # ./spec/item_spec.rb:86:in `block (4 levels) in <top (required)>'

  4) SalesEngine merchants Business Intelligence .revenue returns all revenue for a specific date
     Failure/Error: revenue.should == BigDecimal.new("2549722.91")
       expected: #<BigDecimal:101504360,'0.254972291E7',18(18)>
            got: #<BigDecimal:1015044c8,'0.0',9(18)> (using ==)
     # ./spec/merchant_spec.rb:67:in `block (4 levels) in <top (required)>'

  5) SalesEngine merchants Business Intelligence #revenue without a date reports all revenue
     Failure/Error: merchant.revenue.should == BigDecimal.new("1148393.74")
       expected: #<BigDecimal:1019e7be8,'0.114839374E7',18(18)>
            got: #<BigDecimal:1019e7f08,'0.1148394E7',9(27)> (using ==)
     # ./spec/merchant_spec.rb:92:in `block (5 levels) in <top (required)>'

  6) SalesEngine merchants Business Intelligence #revenue given a date restricts to that date
     Failure/Error: merchant.revenue(date).should == BigDecimal.new("8373.29")
     ArgumentError:
       wrong number of arguments (1 for 0)
     # /Users/jessicag/sales_engine/lib/merchant.rb:26:in `revenue'
     # ./spec/merchant_spec.rb:101:in `block (5 levels) in <top (required)>'

  7) SalesEngine merchants Business Intelligence #customers_with_pending_invoices returns the total number of customers with pending invoices
     Failure/Error: customers.count.should == 4
       expected: 4
            got: 9 (using ==)
     # ./spec/merchant_spec.rb:127:in `block (4 levels) in <top (required)>'
