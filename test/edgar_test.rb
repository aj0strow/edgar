require 'helper'

class EdgarTest < Minitest::Test
  def test_lookup
    results = Edgar.lookup('epcylon')
    assert_includes(results, [ '0001464766', 'EPCYLON TECHNOLOGIES, INC.' ])
  end

  def company
    @company ||= Edgar::Company.new('0001464766')
  end

  def test_company_fetch_and_parse
    assert_equal company.per_page, company.fetch_and_parse.entries.count
  end

  def test_company_entries
    n = 0
    limit = company.per_page + 5
    entries = company.entries.take_while { (n += 1) <= limit }
    assert_equal company.requests, 2
    assert_equal entries.count, limit
  end
end
