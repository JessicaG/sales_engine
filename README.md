# Sales Engine

## Sales Engine is a project from Turing School, used to fulfill the following goals:

* Use tests to drive both the design and implementation of code with high test coverage
* Build a complex system using multiple interacting classes
* Reuse implementation code via duck typing and modules
* Separate parsing / data loading logic from business logic
* Use memoization and careful variable scoping to improve performance

## Abstract

Let’s write a data reporting tool that manipulates and reports on merchant transactional data.

Project done by Jessica Goulding and Glen Egbert.

## The Sisterhood of the Traveling Sales Engines

Lets take this Sales Engine, and use it with data from the internet
instead of from the file system! (thanks, Jess, for volunteering!)

Our work is in [sales_engine_service.rb](https://github.com/JessicaG/sales_engine/blob/master/sales_engine_service.rb),
and [lib/internet_sales_engine.rb](https://github.com/JessicaG/sales_engine/blob/master/lib/internet_sales_engine.rb).

In class, we tried to use docs to figure out how to set the mime type.
That didn't work well, so I decided to just go to the source code instead.
This was a much better plan, I found it within 30 seconds,
https://github.com/sinatra/sinatra/blob/298466de07baa85a4aa01eb91145fa26c4342d55/lib/sinatra/base.rb#L313-319
The code is updated to reflect this.

### Understanding HTTP

First, we figured out how requsts and responses work:
The client (such as a web browser, or curl, or the `RestClient` gem)
sends a request to the server, and the server sends back a response.

An **HTTP Request** is text that gets sent to the server, containing:

1. Line 1:
  * The "method" or "verb", these had values like "GET", "POST", "DELETE", etc
  * The path, these have values like "/merchants". If we went to
    [https://en.wikipedia.org/wiki/List_of_HTTP_status_codes](https://en.wikipedia.org/wiki/List_of_HTTP_status_codes),
    then the path would be `/wiki/List_of_HTTP_status_codes`
2. The headers:
  * Key value pairs, like a hash.
  * These have values that are useful for helping the server understand the request.
  * Examples: `User-Agent: curl/7.30.0`, cookies are also headers with a key of `Cookie:`
3. The body: This comes after a blank line. We didn't send any, but when you submit a form, for example, it will send the data in the body.

An **HTTP Response** is text that gets sent back from the server, after it receives a request.
It contains all the same things as the request, but the first line is different, and the headers
will be different.

1. Line 1:
  * The response code, eg `200`, `404`, `500`.  This tells the client whether the request was successful.
2. The headers:
  * Key value pairs, like a hash.
  * These have values that are useful for helping the client understand the response.
  * Examples: `Server: Cowboy`, `Content-Type: text/html; charset=utf-8`, `Content-Length: 2612`
3. The body: This is where the HTML is placed. Or, in our case, the CSV data.
   If we'd had a bit more time, I'd have made it return other formats, as well, such as JSON and YAML.

### Example Request:

We can run `nc` to start a server that will print out the requests it gets.
The `-l` flag tells it that the address it is on is the address of my local computer.
Every program that can be talked to, from the outside world, needs a number to identify it
(you can think of them as being stored in a giant array, and you have to tell the computer
the index of the program that you want to talk to).
This is called the port, in our case, the port is 3000.
You can pretty much pick whatever number you want, unless some other program has already taken it.

After you run `nc -l 3000`, it will wait for a request. Go to your browser, and enter "http://localhost:3000/merchants",
we'll see the request that our browser sends to the server. This is the actual request that the browser
actually sends across the internet. It ends in a blank line, because that's what separates the headers from the body,
but we have no body.

```http
$ nc -l 3000
GET /merchants HTTP/1.1
Host: localhost:3000
Connection: keep-alive
Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/42.0.2311.135 Safari/537.36
Accept-Encoding: gzip, deflate, sdch
Accept-Language: en-US,en;q=0.8
Cookie: _dinner-dash_session=SDdtUjVOc3pSTGhtcGRuSmtxbkhNMlVYcnFtRU5NaGJENTBjbEJLVU5NdDZUamlFczA2SE5hSlFhNE4xSUxWU0MxTzRGZ1VXU1lWQXlROUI0dk8yZXExbWU0ckhTK0lhODJLM2lLREhJb0t2MkdwQzdvbXlsWW9CUXZpYnk0dGFEbXlIZHBUUlY1eEljYmMzczF0TnVRPT0tLVZXamZxKzA5dWt5RUZHRENTMW5lOWc9PQ%3D%3D--ba3a5350796e82d152f8883ae059695654b75aee

```

### Example Response:

We can invoke the program `curl` and give it the argument `-i`,
to see the full response. We'll hit `http://today.turing.io`,
because it's a website that we go to every day. This is exactly
what the server returns to our web browser, but normally we
can't see this stuff, we only see the interpreted HTML,
displayed to us as links and boxes with colour and such.

```http
$ curl -i http://today.turing.io
HTTP/1.1 200 OK
Server: Cowboy
Date: Fri, 08 May 2015 17:51:39 GMT
Connection: keep-alive
Last-Modified: Fri, 08 May 2015 15:06:54 GMT
Content-Type: text/html; charset=utf-8
Content-Length: 2612
Via: 1.1 vegur

<!DOCTYPE html>
<html lang='en'>
  <head>
    ...omitted...
  </head>
  <body class='index'>
    ...omitted...
  </body>
</html>
```

### So what do we need to do?

So, we need to make a Sales Engine, and it needs to get its data from
the internet instead of the local file system.

It will send a request, like we see above, to a server.
The server will receive the request, find the data, and return it.

Then the SalesEngine needs to initialize all its repositories with this data.


### Writing the server

We could write code that receives the request we saw above,
and parses it to find what it needs. This is worth doing,
it's not too difficult, and it's very grounding, I have a
[server tutorial](https://github.com/turingschool/lesson_plans/tree/master/electives/building-a-webserver),
that you can go through, but you can even make it simpler than that,
(ignore the threads), if you just want to play with receiving and returning HTTP.

Instead of going to that effort, we'll use a gem,
[Sinatra](http://www.sinatrarb.com/),
which will handle these details for us,
and give us a convenient way to tell it what we want to do.

To avoid having to explain how to wire Sinatra to the web,
we're going to put our code in `Sinatra::Application`,
which will be automatically wired up for us.

```ruby
require 'sinatra'

class Sinatra::Application
  # This code tells Sinatra that if the first line of the request
  # has the word "GET", and if the path is "/anything", then the code
  # in this block should be used to handle it.
  #
  # The colon in `"/:repo_name"` tells Sinatra that this can be any value,
  # and we want to be able to access it from a hash, using hte key of `"repo_name"`
  get('/:repo_name') do
    # We placed a pry into here to figure out how to get what we need.
    # We figured out how to get the repo name, from the path, using `params['repo_name']`
    # From there, we figured out how to get the path to the data.
    # And then how to return that as CSV data.
    content_type 'text/csv'
    File.open("data/#{params['repo_name']}.csv")
  end
end
```

For simple programs like this, we can run it directly with Ruby,
and Sinatra will hook it up for us.

```sh
$ ruby sales_engine_service.rb
== Sinatra (v1.4.6) has taken the stage on 4567 for development with backup from Thin
Thin web server (v1.6.3 codename Protein Powder)
Maximum connections set to 1024
Listening on localhost:4567, CTRL+C to stop
```

We see that it picked port 4567 (where, earlier, we picked port 3000).
We make a request to it using curl (here, I truncate the results to ten lines,
by sending the output through `head` before printing them to my console).

```
$ curl -si localhost:4567/merchants | head
HTTP/1.1 200 OK
Content-Type: text/csv;charset=utf-8
X-Content-Type-Options: nosniff
Connection: close
Server: thin

id,name,created_at,updated_at
1,Schroeder-Jerde,2012-03-27 14:53:59 UTC,2012-03-27 14:53:59 UTC
2,"Klein, Rempel and Jones",2012-03-27 14:53:59 UTC,2012-03-27 14:53:59 UTC
3,Willms and Sons,2012-03-27 14:53:59 UTC,2012-03-27 14:53:59 UTC
```

And if we look at our server again, we can see that it added a line,
showing the request that came in.

```
$ ruby sales_engine_service.rb
== Sinatra (v1.4.6) has taken the stage on 4567 for development with backup from Thin
Thin web server (v1.6.3 codename Protein Powder)
Maximum connections set to 1024
Listening on localhost:4567, CTRL+C to stop
127.0.0.1 - - [08/May/2015:12:30:59 -0600] "GET /merchants HTTP/1.1" 200 - 0.0246
```

Nice, now I just need a Sales Engine that can send this request,
and deal with the response.


### Writing the SalesEngine

We take a look at the existing [lib/sales_engine.rb](https://github.com/JessicaG/sales_engine/blob/master/lib/sales_engine.rb):

```ruby
class SalesEngine
  # ...
  def initialize(directory = './test/fixtures')
    @directory = directory
  end

  def load_repositories
    @merchant_rows     ||= RepositoryParser.load(@directory + '/merchants.csv')
    @customer_rows     ||= RepositoryParser.load(@directory + '/customers.csv')
    @invoice_rows      ||= RepositoryParser.load(@directory + '/invoices.csv')
    @invoice_item_rows ||= RepositoryParser.load(@directory + '/invoice_items.csv')
    @item_rows         ||= RepositoryParser.load(@directory + '/items.csv')
    @transaction_rows  ||= RepositoryParser.load(@directory + '/transactions.csv')
  end

  def startup
    load_repositories
    @merchant_repository      ||= MerchantRepository.new(self, merchant_rows)
    @customer_repository      ||= CustomerRepository.new(self, customer_rows)
    @invoice_repository       ||= InvoiceRepository.new(self, invoice_rows)
    @invoice_item_repository  ||= InvoiceItemRepository.new(self, invoice_item_rows)
    @item_repository          ||= ItemRepository.new(self, item_rows)
    @transaction_repository   ||= TransactionRepository.new(self, transaction_rows)
  end
  # ...
end
```

The `initialize` method takes a directory, `load_data` gets the data from the CSV on the file system.
These two pieces don't make sense to us, we want to send a request to the server to get the data.

But it's written well, because if we can change these two methods, then everything else will still work!
The `startup` just takes the data that `load_data` parsed, and hands it to the repositories.

So, we decide to subclass `SalesEngine`, that way we can define our own `initialize` and `load_data`
that get the data the way that we want. All the other methods will be there, because
["Get classy, stay super!"](https://gist.github.com/JoshCheek/f2f4fed0c184ad9dbe98).

We decide it should be initialized with the address of the server,
which we name `base_url`, and then we copy the existing `load_repositories`
method into our subclass. We decide that instead of handing it to the RepositoryParser.load,
we'll just have a method, `fetch`, which will parse the CSV, but from the
web instead of from the file system.

```ruby
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
    require "pry"
    binding.pry
  end
end

se = InternetSalesEngine.new('http://localhost:4567')
se.startup
```

Now, we run this file, and get placed into the `fetch` method.
We double check the url, it all looks good. How do we make the request, though?

Someone suggests we use backticks and call `curl`, and this will totally work!
The downside, though, is that if anything goes wrong,
it will be a lot harder to handle it correctly.
So, instead, we decide to use a gem for making web requests.
It will send the request the same way that our browser does, or that curl does.
I pick the easiest one I know of, `RestClient`,
and we look around in pry a bit, to see how to pull it off.
Eventually, we find the `get` method, and give that a shot.
It works, and returns the body as a String!
(fun fact: this string has useful things added to its singleton class)

```
require 'rest-client'
require_relative 'sales_engine'

class InternetSalesEngine < SalesEngine
  # ...
  def fetch(url)
    csv_data = RestClient.get(url)
    require "pry"
    binding.pry
  end
ene
```

From here, we take a few guesses, and eventually determine that
we can do `CSV.new(filename)`, but that doesn't seem to treat the headers right.
A guess, that the hash arguments the [RepositoryParser](https://github.com/JessicaG/sales_engine/blob/8918763e3badd3ca357940bf9ec5343abbb71b46/lib/repository_parser.rb#L5)
handed to `CSV.open` will probably also work for `CSV.new`,
so we try passing those, and it gives us what we want!

So, now we have all the pieces we need! We finish off
[InternetSalesEngine](https://github.com/JessicaG/sales_engine/blob/master/lib/internet_sales_engine.rb),
and give it a shot!

```ruby
require 'rest-client'
require_relative 'sales_engine'

class InternetSalesEngine < SalesEngine
  # ...
  def fetch(url)
    csv_data = RestClient.get(url)
    CSV.new(csv_data, headers: true, header_converters: :symbol)
  end
end

se = InternetSalesEngine.new('http://localhost:4567')
se.startup
require "pry"
binding.pry
```

We look at our server, and see all the requests come in:

```
$ ruby sales_engine_service.rb
== Sinatra (v1.4.6) has taken the stage on 4567 for development with backup from Thin
Thin web server (v1.6.3 codename Protein Powder)
Maximum connections set to 1024
Listening on localhost:4567, CTRL+C to stop
127.0.0.1 - - [08/May/2015:12:55:30 -0600] "GET /merchants HTTP/1.1" 200 - 0.0066
127.0.0.1 - - [08/May/2015:12:55:30 -0600] "GET /customers HTTP/1.1" 200 - 0.0030
127.0.0.1 - - [08/May/2015:12:55:30 -0600] "GET /invoices HTTP/1.1" 200 - 0.0079
127.0.0.1 - - [08/May/2015:12:55:30 -0600] "GET /invoice_items HTTP/1.1" 200 - 0.0416
127.0.0.1 - - [08/May/2015:12:55:30 -0600] "GET /items HTTP/1.1" 200 - 0.0076
127.0.0.1 - - [08/May/2015:12:55:30 -0600] "GET /transactions HTTP/1.1" 200 - 0.0099
```

Notice that the decision, in this code, to keep the repositories agnostic to the source of the data
allowed us to subclass SalesEngine, and just change the bit that was different. This turned out to
be super easy, I was expecting to have to do some refactoring to get my plan to work, but due to this
design, we didn't have to change anything! This is why design matters. The less your code assumes
about the context of it's caller, the better.

### Have a great intermission week!

Cheers, y'all!
