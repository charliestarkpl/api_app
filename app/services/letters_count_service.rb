require 'nokogiri'
require 'open-uri'

class LettersCountService
  REGEX = /http[s]?:\/\/(start-up)/i
  BASE_URL = 'https://start-up.house/'

  attr_reader :query, :letters_count, :current_date

  def initialize(params)
    @query = permited_params(params)
    @current_date = DateTime.now.strftime('%F')
  end

  def call
    find_site_links
    find_string(@query)
  end

  private

  def find_site_links
   doc = Nokogiri::HTML(open(BASE_URL))
   hrefs = doc.css("a").map do |link|
     if (href = link.attr("href")) && !href.empty?
       URI::join(BASE_URL, href)
     end
   end.compact.uniq

   @urls = hrefs.map {|uri| uri.to_s if uri.to_s =~ (REGEX)}.compact
   @urls = @urls.empty? ? @urls << BASE_URL : @urls
  end

  def find_string(param)
    @letters_count = 0
    @urls.each do |url|
      doc = Nokogiri::HTML(open(url))
      @letters_count += doc.text.count(param.to_s)
    end
  end

  def permited_params(params)
    params.require(:query)
  end
end
