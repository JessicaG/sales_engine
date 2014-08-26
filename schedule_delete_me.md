TODOS:
Spec Harness Failures
- to_i
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

####
Errors for spec harness:
Customer Failures:
) SalesEngine customers Searching .find_all_by_first_name can find multiple records
     Failure/Error: customers.should have(2).customers
     NoMethodError:
       undefined method `have' for #<RSpec::ExampleGroups::SalesEngineCustomers::Searching::FindAllByFirstName:0x00000105d19880>
     # ./spec/customer_spec.rb:31:in `block (4 levels) in <top (required)>'

  2) SalesEngine customers Relationships #invoices returns all of a customer's invoices
     Failure/Error: customer.invoices.should have(7).invoices
     NoMethodError:
       undefined method `have' for #<RSpec::ExampleGroups::SalesEngineCustomers::Relationships::Invoices:0x00000105c09a08>
     # ./spec/customer_spec.rb:42:in `block (4 levels) in <top (required)>'

  3) SalesEngine customers Relationships #invoices returns invoices belonging to the customer
     Failure/Error: invoice.customer_id.should == 999
       expected: 999
            got: "999" (using ==)
     # ./spec/customer_spec.rb:47:in `block (5 levels) in <top (required)>'
     # ./spec/customer_spec.rb:46:in `each'
     # ./spec/customer_spec.rb:46:in `block (4 levels) in <top (required)>'

  4) SalesEngine customers Business Intelligence #transactions returns a list of transactions the customer has had
     Failure/Error: customer.transactions.should have(1).transaction
     NameError:
       undefined local variable or method `repository' for #<Customer:0x000001012cf8b0>
     # /Users/jessicag/sales_engine/lib/customer.rb:26:in `transactions'
     # ./spec/customer_spec.rb:58:in `block (4 levels) in <top (required)>'

  5) SalesEngine customers Business Intelligence #favorite_merchant returns the merchant where the customer has had the most transactions
     Failure/Error: customer.favorite_merchant.name.should == "Shields, Hirthe and Smith"
     NameError:
       undefined local variable or method `repository' for #<Customer:0x000001012cf8b0>
     # /Users/jessicag/sales_engine/lib/customer.rb:30:in `favorite_merchant'
     # ./spec/customer_spec.rb:64:in `block (4 levels) in <top (required)>'

Invoice Item Failures:
  1) SalesEngine invoice items Searching .find_all_by_quantity can find multiple records
     Failure/Error: invoice_items.should have(2140).invoice_items
     NoMethodError:
       undefined method `have' for #<RSpec::ExampleGroups::SalesEngineInvoiceItems::Searching::FindAllByQuantity:0x00000105228390>
     # ./spec/invoice_item_spec.rb:29:in `block (4 levels) in <top (required)>'

Item Failures:
  1) SalesEngine items Searching .find_by_unit_price can find one record
     Failure/Error: item = engine.item_repository.find_by_unit_price BigDecimal.new("935.19")
     NoMethodError:
       undefined method `find_by_unit_price' for #<ItemRepository 2483 rows>
     # ./spec/item_spec.rb:21:in `block (4 levels) in <top (required)>'

  2) SalesEngine items Searching .find_all_by_name can find multiple records
     Failure/Error: items = engine.item_repository.find_all_by_name "Item Eos Et"
     NoMethodError:
       undefined method `find_all_by_name' for #<ItemRepository 2483 rows>
     # ./spec/item_spec.rb:28:in `block (4 levels) in <top (required)>'

  3) SalesEngine items Relationships #invoice_items has the correct number of them
     Failure/Error: let(:item) { engine.item_repository.find_by_name "Item Saepe Ipsum" }
     NoMethodError:
       undefined method `find_by_name' for #<ItemRepository 2483 rows>
     # ./spec/item_spec.rb:35:in `block (3 levels) in <top (required)>'
     # ./spec/item_spec.rb:39:in `block (4 levels) in <top (required)>'

  4) SalesEngine items Relationships #invoice_items really owns them all
     Failure/Error: let(:item) { engine.item_repository.find_by_name "Item Saepe Ipsum" }
     NoMethodError:
       undefined method `find_by_name' for #<ItemRepository 2483 rows>
     # ./spec/item_spec.rb:35:in `block (3 levels) in <top (required)>'
     # ./spec/item_spec.rb:43:in `block (4 levels) in <top (required)>'

  5) SalesEngine items Relationships #merchant exists
     Failure/Error: let(:item) { engine.item_repository.find_by_name "Item Saepe Ipsum" }
     NoMethodError:
       undefined method `find_by_name' for #<ItemRepository 2483 rows>
     # ./spec/item_spec.rb:35:in `block (3 levels) in <top (required)>'
     # ./spec/item_spec.rb:51:in `block (4 levels) in <top (required)>'

  6) SalesEngine items Business Intelligence .most_revenue returns the top n items ranked by most total revenue
     Failure/Error: most = engine.item_repository.most_revenue(5)
     NoMethodError:
       undefined method `successful?' for #<InvoiceItem:0x000001017f1398>
     # /Users/jessicag/sales_engine/lib/item.rb:54:in `each'
     # /Users/jessicag/sales_engine/lib/item.rb:54:in `find_all'
     # /Users/jessicag/sales_engine/lib/item.rb:54:in `paid_invoice_items'
     # /Users/jessicag/sales_engine/lib/item.rb:49:in `amount_sold'
     # /Users/jessicag/sales_engine/lib/item.rb:45:in `revenue'
     # /Users/jessicag/sales_engine/lib/item_repository.rb:54:in `block in most_revenue'
     # /Users/jessicag/sales_engine/lib/item_repository.rb:54:in `each'
     # /Users/jessicag/sales_engine/lib/item_repository.rb:54:in `sort_by'
     # /Users/jessicag/sales_engine/lib/item_repository.rb:54:in `most_revenue'
     # ./spec/item_spec.rb:61:in `block (4 levels) in <top (required)>'

  7) SalesEngine items Business Intelligence .most_items returns the top n items ranked by most sold
     Failure/Error: most = engine.item_repository.most_items(37)
     NoMethodError:
       undefined method `successful?' for #<InvoiceItem:0x000001017f1398>
     # /Users/jessicag/sales_engine/lib/item.rb:54:in `each'
     # /Users/jessicag/sales_engine/lib/item.rb:54:in `find_all'
     # /Users/jessicag/sales_engine/lib/item.rb:54:in `paid_invoice_items'
     # /Users/jessicag/sales_engine/lib/item.rb:49:in `amount_sold'
     # /Users/jessicag/sales_engine/lib/item_repository.rb:58:in `block in most_items'
     # /Users/jessicag/sales_engine/lib/item_repository.rb:58:in `each'
     # /Users/jessicag/sales_engine/lib/item_repository.rb:58:in `sort_by'
     # /Users/jessicag/sales_engine/lib/item_repository.rb:58:in `most_items'
     # ./spec/item_spec.rb:70:in `block (4 levels) in <top (required)>'

  8) SalesEngine items Business Intelligence #best_day returns something castable to date
     Failure/Error: let(:item) { engine.item_repository.find_by_name "Item Accusamus Ut" }
     NoMethodError:
       undefined method `find_by_name' for #<ItemRepository 2483 rows>
     # ./spec/item_spec.rb:78:in `block (4 levels) in <top (required)>'
     # ./spec/item_spec.rb:86:in `block (4 levels) in <top (required)>'

Merchant Failures:
Stuck! :(

Transaction Failures:

  1) SalesEngine  transactions Searching .find_by_credit_card_number can find a record
     Failure/Error: transaction.id.should == 5536
       expected: 5536
            got: "5536" (using ==)
     # ./spec/transaction_spec.rb:23:in `block (4 levels) in <top (required)>'

Invoice Failures:

  ##Undefined method "have"
  1) SalesEngine invoices Searching .find_all_by_status can find multiple records
     Failure/Error: invoices.should have(4843).invoices
     NoMethodError:
       undefined method `have' for #<RSpec::ExampleGroups::SalesEngineInvoices::Searching::FindAllByStatus:0x00000104562d90>
     # ./spec/invoice_spec.rb:29:in `block (4 levels) in <top (required)>'

  2) SalesEngine invoices Relationships #transactions has the correct number of them
     Failure/Error: invoice.transactions.should have(1).transaction
     NoMethodError:
       undefined method `have' for #<RSpec::ExampleGroups::SalesEngineInvoices::Relationships::Transactions:0x00000101e14810>
     # ./spec/invoice_spec.rb:39:in `block (4 levels) in <top (required)>'

  3) SalesEngine invoices Relationships #items has the correct number of them
     Failure/Error: invoice.items.should have(3).items
     NoMethodError:
       undefined method `have' for #<RSpec::ExampleGroups::SalesEngineInvoices::Relationships::Items:0x0000010615a548>
     # ./spec/invoice_spec.rb:45:in `block (4 levels) in <top (required)>'

  4) SalesEngine invoices Relationships #invoice_items has the correct number of them
     Failure/Error: invoice.invoice_items.should have(3).items
     NoMethodError:
       undefined method `have' for #<RSpec::ExampleGroups::SalesEngineInvoices::Relationships::InvoiceItems:0x000001046b1278>
     # ./spec/invoice_spec.rb:63:in `block (4 levels) in <top (required)>'

  ##Need to complete invoice creation
  5) SalesEngine invoices Business Intelligence .create creates a new invoice
     Failure/Error: invoice = engine.invoice_repository.create(customer: customer, merchant: merchant, items: items)
     NoMethodError:
       undefined method `create' for #<InvoiceRepository 4843 rows>
     # ./spec/invoice_spec.rb:83:in `block (4 levels) in <top (required)>'


  6) SalesEngine invoices Business Intelligence #charge creates a transaction
     Failure/Error: invoice.charge(credit_card_number: '1111222233334444',  credit_card_expiration_date: "10/14", result: "success")
     NoMethodError:
       undefined method `charge' for #<Invoice:0x00000102670220>
     # ./spec/invoice_spec.rb:99:in `block (4 levels) in <top (required)>'
