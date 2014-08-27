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
       undefined method `charge' for #<Invoice:0x0000010233ab50>
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

  4) SalesEngine merchants Searching .find_all_by_name can find multiple records
     Failure/Error: merchants = engine.merchant_repository.find_all_by_name "Williamson Group"
     NoMethodError:
       undefined method `find_all_by_name' for #<MerchantRepository 100 rows>
     # ./spec/merchant_spec.rb:28:in `block (4 levels) in <top (required)>'

  5) SalesEngine merchants Business Intelligence .revenue returns all revenue for a specific date
     Failure/Error: revenue.should == BigDecimal.new("2549722.91")
       expected: #<BigDecimal:1013a0910,'0.254972291E7',18(18)>
            got: #<BigDecimal:1013a0d20,'0.0',9(18)> (using ==)
     # ./spec/merchant_spec.rb:67:in `block (4 levels) in <top (required)>'
