require 'httparty'

module Api
  class IntentRecognizer
    def recognize(query:)
      response = HTTParty.get("https://westus.api.cognitive.microsoft.com/luis/v2.0/apps/99dd0e0c-a5af-4e6d-bde0-75b12247da4e?verbose=true&timezoneOffset=-360&subscription-key=#{ENV['INTENT_RECOGNIZER_API_KEY']}&q=#{query}")
      [response.dig('topScoringIntent', 'intent').downcase, response.dig('entities')[0]['entity']]
    end
  end
end