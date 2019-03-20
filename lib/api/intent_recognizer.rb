require 'httparty'

module Api
  class IntentRecognizer
    def recognize(query:)
      response = HTTParty.get("https://westus.api.cognitive.microsoft.com/luis/v2.0/apps/99dd0e0c-a5af-4e6d-bde0-75b12247da4e?verbose=true&timezoneOffset=-360&subscription-key=8059ea18a3cc40358df4e1d6931ba4de&q=#{query}")
      response.dig('topScoringIntent', 'intent')
    end
  end
end