require 'httparty'

module Api
  class Quote
    def fetch(query:)
      response = HTTParty.get("https://thesimpsonsquoteapi.glitch.me/quotes?count=1")
      return {
        quote: response["quote"],
        charater: response["character"],
        image: response["image"]
      }
    end
  end
end