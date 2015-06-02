# `edgar`

From the [SEC website](http://www.sec.gov/edgar.shtml):

> All companies, foreign and domestic, are required to file registration statements, periodic reports, and other forms electronically through EDGAR. Anyone can access and download this information for free. 

This isn't a financial analysis tool. It parses an rss feed to list filings on the corporate website. It's dead simple (<60 SLOC). 

### How To
 
You need the company CIK (a unique id).

```ruby
Edgar.lookup('epcylon').first
# => [ '0001464766', 'EPCYLON TECHNOLOGIES, INC.' ]
```

Page through rss entries with a lazy enumerator. The default `per_page` is `20` but you can set it to something else. It keeps track of requests sent too.

```ruby
company = Edgar::Company.new('0001464766')
company.entries.each { |entry| puts entry.entry_id }
company.requests
# => 6
```

You don't need to go through all the pages.

```ruby
company = Edgar::Company.new('0001464766')
entries = company.entries.take_while { |entry| entry.updated > 3.months.ago }
company.requests
# => 1
```

### Entry

An entry looks like this.

```ruby
  @categories = [ '8-K' ]
  @entry_id = 'urn:tag:sec.gov,2008:accession-number=0001062993-15-003044'
  @links = [ ... ]
  @content = '...'
  @summary = "<b>Filed:</b> 2015-05-26 <b>AccNo:</b> 0001062993-15-003044 <b>Size:</b> 12 KB<br>Item 5.02: Departure of Directors or Certain Officers; Election of Directors; Appointment of Certain Officers: Compensatory Arrangements of Certain Officers<br>Item 9.01: Financial Statements and Exhibits"
  @title = "8-K  - Current report
  @updated = 2015-05-26 15:56:36 UTC
  @url = "http://www.sec.gov/Archives/edgar/data/1464766/000106299315003044/0001062993-15-003044-index.htm"
```

### Install

Available as a ruby gem from source. 

```ruby
gem 'edgar', github: 'aj0strow/edgar'
```

```
$ bundle install
```

**MIT License**
