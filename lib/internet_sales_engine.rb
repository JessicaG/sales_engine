require 'rest-client'
require_relative 'sales_engine'

class InternetSalesEngine < SalesEngine
  def initialize(base_url)
    @base_url = base_url # "http://localhost:4567"
  end

  def load_repositories
    @merchant_rows     ||= fetch(@base_url + '/merchants')
    @customer_rows     ||= fetch(@base_url + '/customers')
    @invoice_rows      ||= fetch(@base_url + '/invoices')
    @invoice_item_rows ||= fetch(@base_url + '/invoice_items')
    @item_rows         ||= fetch(@base_url + '/items')
    @transaction_rows  ||= fetch(@base_url + '/transactions')
  end

  # "http://localhost:4567/merchants"
  def fetch(url)
    csv_data = RestClient.get(url)
    CSV.new(csv_data, headers: true, header_converters: :symbol)
  end
end



se = InternetSalesEngine.new('http://localhost:4567')
se.startup

se.customer_repository          # => #<CustomerRepository 1000 rows>
  .find_by_first_name('Mariah') # => #<Customer:0x007fec34d09c88 @id=3, @first_name="Mariah", @last_name="Toy", @created_at="2012-03-27 14:54:10 UTC", @updated_at="2012-03-27 14:54:10 UTC", @customer_repository=#<CustomerRepository 1000 rows>>
  .invoices                     # => [#<Invoice:0x007fec33c002e8 @id=10, @customer_id=3, @merchant_id=86, @created_at=#<Date: 2012-03-06 ((2455993j,0s,0n),+0s,2299161j)>, @updated_at=#<Date: 2012-03-06 ((2455993j,0s,0n),+0s,2299161j)>, @status="shipped", @invoice_repository=#<InvoiceRepository 4843 rows>>, #<Invoice:0x007fec3688f048 @id=11, @customer_id=3, @merchant_id=62, @created_at=#<Date: 2012-03-08 ((2455995j,0s,0n),+0s,...
  .first                        # => #<Invoice:0x007fec33c002e8 @id=10, @customer_id=3, @merchant_id=86, @created_at=#<Date: 2012-03-06 ((2455993j,0s,0n),+0s,2299161j)>, @updated_at=#<Date: 2012-03-06 ((2455993j,0s,0n),+0s,2299161j)>, @status="shipped", @invoice_repository=#<InvoiceRepository 4843 rows>>
  .invoice_items                # => [#<InvoiceItem:0x007fec34f7bb60 @id=49, @item_id=2061, @invoice_id=10, @quantity=4, @unit_price=#<BigDecimal:7fec34f7b610,'0.17154E3',18(18)>, @created_at="2012-03-27 14:54:10 UTC", @updated_at="2012-03-27 14:54:10 UTC", @invoice_item_repository=#<InvoiceItemRepository 21687 rows>>, #<InvoiceItem:0x007fec34f7aa58 @id=50, @item_id=2055, @invoice_id=10, @quantity=6, @unit_price=#<BigDecimal:...
  .first.item                   # => #<Item:0x007fec37e674b0 @id=2061, @name="Item Ratione Dolor", @description="Ut sequi ducimus illo in enim. Architecto soluta omnis et odio debitis qui. Vel dolorem aut quia.", @unit_price=#<BigDecimal:7fec37e672f8,'0.17154E3',18(18)>, @merchant_id=86, @created_at="2012-03-27 14:54:07 UTC", @updated_at="2012-03-27 14:54:07 UTC", @item_repository=#<ItemRepository 2483 rows>>
  .name                         # => "Item Ratione Dolor"
