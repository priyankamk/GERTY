require 'httparty'

module Api
  class Quote
    def fetch(query:)
      response = HTTParty.get(
        "http://quotes.rest/quote/search?minlength=100&maxlength=300&query=#{query}&private=false",
        headers: {
          'X-TheySaidSo-Api-Secret': '3_BkOSsR9g7E8Ys3zEa6_QeF'
        })
      return {
        quote: response["contents"]["quote"],
        author: response["contents"]["author"]
      }
    end
  end
end