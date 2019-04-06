require 'httparty'

module Api
  class Quote
    def self.fetch(query:)
      response = HTTParty.get(
        "http://quotes.rest/quote/search?minlength=100&maxlength=300&query=#{query}&private=false",
        headers: {
          'X-TheySaidSo-Api-Secret': "#{ENV['QUOTE_API_KEY']}"
        })
      return {
        quote: response["contents"]["quote"],
        author: response["contents"]["author"]
      }
    end
  end
end

