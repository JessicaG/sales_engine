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
       undefined method `charge' for #<Invoice:0x00000102b72e08>
     # ./spec/invoice_spec.rb:99:in `block (4 levels) in <top (required)>'

  3) SalesEngine items Searching .find_by_unit_price can find one record
     Failure/Error: item = engine.item_repository.find_by_unit_price BigDecimal.new("935.19")
     NoMethodError:
       undefined method `find_by_unit_price' for #<ItemRepository 2483 rows>
     # ./spec/item_spec.rb:21:in `block (4 levels) in <top (required)>'

  4) SalesEngine items Searching .find_all_by_name can find multiple records
     Failure/Error: items = engine.item_repository.find_all_by_name "Item Eos Et"
     NoMethodError:
       undefined method `find_all_by_name' for #<ItemRepository 2483 rows>
     # ./spec/item_spec.rb:28:in `block (4 levels) in <top (required)>'

  5) SalesEngine items Relationships #invoice_items has the correct number of them
     Failure/Error: let(:item) { engine.item_repository.find_by_name "Item Saepe Ipsum" }
     NoMethodError:
       undefined method `find_by_name' for #<ItemRepository 2483 rows>
     # ./spec/item_spec.rb:35:in `block (3 levels) in <top (required)>'
     # ./spec/item_spec.rb:39:in `block (4 levels) in <top (required)>'

  6) SalesEngine items Relationships #invoice_items really owns them all
     Failure/Error: let(:item) { engine.item_repository.find_by_name "Item Saepe Ipsum" }
     NoMethodError:
       undefined method `find_by_name' for #<ItemRepository 2483 rows>
     # ./spec/item_spec.rb:35:in `block (3 levels) in <top (required)>'
     # ./spec/item_spec.rb:43:in `block (4 levels) in <top (required)>'

  7) SalesEngine items Relationships #merchant exists
     Failure/Error: let(:item) { engine.item_repository.find_by_name "Item Saepe Ipsum" }
     NoMethodError:
       undefined method `find_by_name' for #<ItemRepository 2483 rows>
     # ./spec/item_spec.rb:35:in `block (3 levels) in <top (required)>'
     # ./spec/item_spec.rb:51:in `block (4 levels) in <top (required)>'

  8) SalesEngine items Business Intelligence #best_day returns something castable to date
     Failure/Error: let(:item) { engine.item_repository.find_by_name "Item Accusamus Ut" }
     NoMethodError:
       undefined method `find_by_name' for #<ItemRepository 2483 rows>
     # ./spec/item_spec.rb:78:in `block (4 levels) in <top (required)>'
     # ./spec/item_spec.rb:86:in `block (4 levels) in <top (required)>'

  9) SalesEngine merchants Searching .find_all_by_name can find multiple records
     Failure/Error: merchants = engine.merchant_repository.find_all_by_name "Williamson Group"
     NoMethodError:
       undefined method `find_all_by_name' for #<MerchantRepository 100 rows>
     # ./spec/merchant_spec.rb:28:in `block (4 levels) in <top (required)>'

  10) SalesEngine merchants Business Intelligence .revenue returns all revenue for a specific date
     Failure/Error: revenue.should == BigDecimal.new("2549722.91")
       expected: #<BigDecimal:1030c1788,'0.254972291E7',18(18)>
            got: #<BigDecimal:1030c1bc0,'0.0',9(18)> (using ==)
     # ./spec/merchant_spec.rb:67:in `block (4 levels) in <top (required)>'

  11) SalesEngine merchants Business Intelligence #revenue without a date reports all revenue
     Failure/Error: merchant.revenue.should == BigDecimal.new("1148393.74")
       expected: #<BigDecimal:1011db508,'0.114839374E7',18(18)>
            got: #<BigDecimal:1011db580,'0.1148394E7',9(27)> (using ==)
     # ./spec/merchant_spec.rb:92:in `block (5 levels) in <top (required)>'

  12) SalesEngine merchants Business Intelligence #revenue given a date restricts to that date
     Failure/Error: merchant.revenue(date).should == BigDecimal.new("8373.29")
     ArgumentError:
       wrong number of arguments (1 for 0)
     # /Users/jessicag/sales_engine/lib/merchant.rb:26:in `revenue'
     # ./spec/merchant_spec.rb:101:in `block (5 levels) in <top (required)>'

  13) SalesEngine merchants Business Intelligence #customers_with_pending_invoices returns the total number of customers with pending invoices
     Failure/Error: customers.count.should == 4
       expected: 4
            got: 9 (using ==)
     # ./spec/merchant_spec.rb:127:in `block (4 levels) in <top (required)>'
