require 'httparty'

module Api
  class Quote
    def fetch(query:)
 
      response = HTTParty.get("https://thesimpsonsquoteapi.glitch.me/quotes?count=1")
      {
        quote: response["quote"],
        charater: response["character"],
        image: response["image"]
      }
    end
  end
end