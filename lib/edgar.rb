require 'curb'
require 'nokogiri'
require 'uri'
require 'feedjira'

module Edgar
  BASE_URL = 'http://www.sec.gov'

  def self.lookup(company)
    http = Curl.post(BASE_URL + '/cgi-bin/cik.pl.c', 'company' => company)
    doc = Nokogiri::HTML(http.body_str)
    pre = doc.css('table').css('a').first.parent
    pre.children.map{ |node| node.text.strip }.each_cons(2).to_a
  end

  class Company
    DEFAULT_PARAMS = {
      'action' => 'getcompany',
      'owner' => 'exclude',
      'output' => 'atom'
    }.freeze

    DEFAULT_PER_PAGE = 20

    attr_accessor :per_page
    attr_reader :cik, :requests

    def initialize(cik)
      @cik = cik
      @per_page = DEFAULT_PER_PAGE
      @requests = 0
    end

    def entries
      start = 0
      Enumerator.new do |enum|
        loop do
          feed = fetch_and_parse(start: start)
          raise StopIteration if feed.entries.empty?
          feed.entries.each { |entry| enum.yield entry }
          start += per_page
        end
      end
    end

    def fetch_and_parse(start: 0)
      params = DEFAULT_PARAMS.merge(
        'start' => start,
        'count' => per_page,
        'CIK' => cik
      )
      url = URI(BASE_URL + '/cgi-bin/browse-edgar').tap do |u|
        u.query = URI.encode_www_form(params)
      end
      Feedjira::Feed.fetch_and_parse(url.to_s).tap { @requests += 1 }
    end
  end
end
