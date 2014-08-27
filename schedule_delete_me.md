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
  1) SalesEngine customers Relationships #invoices returns all of a customer's invoices
     Failure/Error: customer.invoices.should have(7).invoices
     NoMethodError:
       undefined method `invoices' for nil:NilClass
     # ./spec/customer_spec.rb:42:in `block (4 levels) in <top (required)>'

  2) SalesEngine customers Relationships #invoices returns invoices belonging to the customer
     Failure/Error: customer.invoices.each do |invoice|
     NoMethodError:
       undefined method `invoices' for nil:NilClass
     # ./spec/customer_spec.rb:46:in `block (4 levels) in <top (required)>'

  3) SalesEngine customers Business Intelligence #transactions returns a list of transactions the customer has had
     Failure/Error: customer.transactions.should have(1).transaction
     NoMethodError:
       undefined method `transactions' for nil:NilClass
     # ./spec/customer_spec.rb:58:in `block (4 levels) in <top (required)>'

  4) SalesEngine customers Business Intelligence #favorite_merchant returns the merchant where the customer has had the most transactions
     Failure/Error: customer.favorite_merchant.name.should == "Shields, Hirthe and Smith"
     NoMethodError:
       undefined method `favorite_merchant' for nil:NilClass
     # ./spec/customer_spec.rb:64:in `block (4 levels) in <top (required)>'

  5) SalesEngine invoice items Searching .find_by_item_id can find a record
     Failure/Error: invoice_item.item.name.should == "Item Doloribus Ducimus"
     NoMethodError:
       undefined method `item' for nil:NilClass
     # ./spec/invoice_item_spec.rb:22:in `block (4 levels) in <top (required)>'

  6) SalesEngine invoice items Searching .find_all_by_quantity can find multiple records
     Failure/Error: invoice_items.should have(2140).invoice_items
       expected 2140 invoice_items, got 0
     # ./spec/invoice_item_spec.rb:29:in `block (4 levels) in <top (required)>'

  7) SalesEngine invoice items Relationships #item exists
     Failure/Error: invoice_item.item.name.should == "Item Cupiditate Magni"
     NoMethodError:
       undefined method `item' for nil:NilClass
     # ./spec/invoice_item_spec.rb:39:in `block (4 levels) in <top (required)>'

  8) SalesEngine invoice items Relationships #invoice exists
     Failure/Error: invoice_item.invoice.should be
     NoMethodError:
       undefined method `invoice' for nil:NilClass
     # ./spec/invoice_item_spec.rb:45:in `block (4 levels) in <top (required)>'

  9) SalesEngine invoices Relationships #transactions has the correct number of them
     Failure/Error: invoice.transactions.should have(1).transaction
     NoMethodError:
       undefined method `transactions' for nil:NilClass
     # ./spec/invoice_spec.rb:39:in `block (4 levels) in <top (required)>'

  10) SalesEngine invoices Relationships #items has the correct number of them
     Failure/Error: invoice.items.should have(3).items
     NoMethodError:
       undefined method `items' for nil:NilClass
     # ./spec/invoice_spec.rb:45:in `block (4 levels) in <top (required)>'

  11) SalesEngine invoices Relationships #items has one with a specific name
     Failure/Error: item = invoice.items.find {|i| i.name == 'Item Accusamus Officia' }
     NoMethodError:
       undefined method `items' for nil:NilClass
     # ./spec/invoice_spec.rb:49:in `block (4 levels) in <top (required)>'

  12) SalesEngine invoices Relationships #customer exists
     Failure/Error: invoice.customer.first_name.should == "Eric"
     NoMethodError:
       undefined method `customer' for nil:NilClass
     # ./spec/invoice_spec.rb:56:in `block (4 levels) in <top (required)>'

  13) SalesEngine invoices Relationships #invoice_items has the correct number of them
     Failure/Error: invoice.invoice_items.should have(3).items
     NoMethodError:
       undefined method `invoice_items' for nil:NilClass
     # ./spec/invoice_spec.rb:63:in `block (4 levels) in <top (required)>'

  14) SalesEngine invoices Relationships #invoice_items has one for a specific item
     Failure/Error: item = invoice.invoice_items.find {|ii| ii.item.name == 'Item Accusamus Officia' }
     NoMethodError:
       undefined method `invoice_items' for nil:NilClass
     # ./spec/invoice_spec.rb:67:in `block (4 levels) in <top (required)>'

  15) SalesEngine invoices Business Intelligence .create creates a new invoice
     Failure/Error: invoice = engine.invoice_repository.create(customer: customer, merchant: merchant, items: items)
     NoMethodError:
       undefined method `create' for #<InvoiceRepository 4843 rows>
     # ./spec/invoice_spec.rb:83:in `block (4 levels) in <top (required)>'

  16) SalesEngine invoices Business Intelligence #charge creates a transaction
     Failure/Error: prior_transaction_count = invoice.transactions.count
     NoMethodError:
       undefined method `transactions' for nil:NilClass
     # ./spec/invoice_spec.rb:97:in `block (4 levels) in <top (required)>'

  17) SalesEngine items Searching .find_by_unit_price can find one record
     Failure/Error: item = engine.item_repository.find_by_unit_price BigDecimal.new("935.19")
     NoMethodError:
       undefined method `find_by_unit_price' for #<ItemRepository 2483 rows>
     # ./spec/item_spec.rb:21:in `block (4 levels) in <top (required)>'

  18) SalesEngine items Searching .find_all_by_name can find multiple records
     Failure/Error: items = engine.item_repository.find_all_by_name "Item Eos Et"
     NoMethodError:
       undefined method `find_all_by_name' for #<ItemRepository 2483 rows>
     # ./spec/item_spec.rb:28:in `block (4 levels) in <top (required)>'

  19) SalesEngine items Relationships #invoice_items has the correct number of them
     Failure/Error: let(:item) { engine.item_repository.find_by_name "Item Saepe Ipsum" }
     NoMethodError:
       undefined method `find_by_name' for #<ItemRepository 2483 rows>
     # ./spec/item_spec.rb:35:in `block (3 levels) in <top (required)>'
     # ./spec/item_spec.rb:39:in `block (4 levels) in <top (required)>'

  20) SalesEngine items Relationships #invoice_items really owns them all
     Failure/Error: let(:item) { engine.item_repository.find_by_name "Item Saepe Ipsum" }
     NoMethodError:
       undefined method `find_by_name' for #<ItemRepository 2483 rows>
     # ./spec/item_spec.rb:35:in `block (3 levels) in <top (required)>'
     # ./spec/item_spec.rb:43:in `block (4 levels) in <top (required)>'

  21) SalesEngine items Relationships #merchant exists
     Failure/Error: let(:item) { engine.item_repository.find_by_name "Item Saepe Ipsum" }
     NoMethodError:
       undefined method `find_by_name' for #<ItemRepository 2483 rows>
     # ./spec/item_spec.rb:35:in `block (3 levels) in <top (required)>'
     # ./spec/item_spec.rb:51:in `block (4 levels) in <top (required)>'

  22) SalesEngine items Business Intelligence .most_revenue returns the top n items ranked by most total revenue
     Failure/Error: most.first.name.should == "Item Dicta Autem"
       expected: "Item Dicta Autem"
            got: "Item Fuga Est" (using ==)
     # ./spec/item_spec.rb:63:in `block (4 levels) in <top (required)>'

  23) SalesEngine items Business Intelligence .most_items returns the top n items ranked by most sold
     Failure/Error: most[1].name.should == "Item Nam Magnam"
       expected: "Item Nam Magnam"
            got: "Item Sint Et" (using ==)
     # ./spec/item_spec.rb:72:in `block (4 levels) in <top (required)>'

  24) SalesEngine items Business Intelligence #best_day returns something castable to date
     Failure/Error: let(:item) { engine.item_repository.find_by_name "Item Accusamus Ut" }
     NoMethodError:
       undefined method `find_by_name' for #<ItemRepository 2483 rows>
     # ./spec/item_spec.rb:78:in `block (4 levels) in <top (required)>'
     # ./spec/item_spec.rb:86:in `block (4 levels) in <top (required)>'

  25) SalesEngine merchants Searching .find_all_by_name can find multiple records
     Failure/Error: merchants = engine.merchant_repository.find_all_by_name "Williamson Group"
     NoMethodError:
       undefined method `find_all_by_name' for #<MerchantRepository 100 rows>
     # ./spec/merchant_spec.rb:28:in `block (4 levels) in <top (required)>'

  26) SalesEngine merchants Relationships #invoices has a shipped invoice for a specific customer
     Failure/Error: invoice = merchant.invoices.find {|i| i.customer.last_name == 'Block' }
     NoMethodError:
       undefined method `last_name' for nil:NilClass
     # ./spec/merchant_spec.rb:54:in `block (5 levels) in <top (required)>'
     # ./spec/merchant_spec.rb:54:in `each'
     # ./spec/merchant_spec.rb:54:in `find'
     # ./spec/merchant_spec.rb:54:in `block (4 levels) in <top (required)>'

  27) SalesEngine merchants Business Intelligence .revenue returns all revenue for a specific date
     Failure/Error: revenue.should == BigDecimal.new("2549722.91")
       expected: #<BigDecimal:1060da1b8,'0.254972291E7',18(18)>
            got: #<BigDecimal:1060da230,'0.0',9(18)> (using ==)
     # ./spec/merchant_spec.rb:67:in `block (4 levels) in <top (required)>'

  28) SalesEngine merchants Business Intelligence .most_revenue returns the top n revenue-earners
     Failure/Error: most.first.name.should == "Dicki-Bednar"
       expected: "Dicki-Bednar"
            got: "Wisozk, Hoeger and Bosco" (using ==)
     # ./spec/merchant_spec.rb:74:in `block (4 levels) in <top (required)>'

  29) SalesEngine merchants Business Intelligence .most_items returns the top n item-sellers
     Failure/Error: most.first.name.should == "Kassulke, O'Hara and Quitzon"
       expected: "Kassulke, O'Hara and Quitzon"
            got: "Wisozk, Hoeger and Bosco" (using ==)
     # ./spec/merchant_spec.rb:82:in `block (4 levels) in <top (required)>'

  30) SalesEngine merchants Business Intelligence #revenue without a date reports all revenue
     Failure/Error: merchant.revenue.should == BigDecimal.new("1148393.74")
       expected: #<BigDecimal:10365ea10,'0.114839374E7',18(18)>
            got: #<BigDecimal:10365eab0,'0.0',9(18)> (using ==)
     # ./spec/merchant_spec.rb:92:in `block (5 levels) in <top (required)>'

  31) SalesEngine merchants Business Intelligence #revenue given a date restricts to that date
     Failure/Error: merchant.revenue(date).should == BigDecimal.new("8373.29")
     ArgumentError:
       wrong number of arguments (1 for 0)
     # /Users/jessicag/sales_engine/lib/merchant.rb:26:in `revenue'
     # ./spec/merchant_spec.rb:101:in `block (5 levels) in <top (required)>'

  32) SalesEngine merchants Business Intelligence #favorite_customer returns the customer with the most transactions
     Failure/Error: customer = merchant.favorite_customer
     NoMethodError:
       undefined method `[]' for nil:NilClass
     # /Users/jessicag/sales_engine/lib/merchant.rb:48:in `favorite_customer'
     # ./spec/merchant_spec.rb:114:in `block (4 levels) in <top (required)>'

  33) SalesEngine merchants Business Intelligence #customers_with_pending_invoices returns the total number of customers with pending invoices
     Failure/Error: customers.count.should == 4
       expected: 4
            got: 0 (using ==)
     # ./spec/merchant_spec.rb:127:in `block (4 levels) in <top (required)>'

  34) SalesEngine  transactions Relationships #invoice exists
     Failure/Error: transaction.invoice.customer.first_name.should == invoice_customer.first_name
     NoMethodError:
       undefined method `invoice' for nil:NilClass
     # ./spec/transaction_spec.rb:41:in `block (4 levels) in <top (required)>'
