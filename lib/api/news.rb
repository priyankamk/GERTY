require 'httparty'

module Api
  class News
    def self.fetch(query:)
      response = HTTParty.get("https://newsapi.org/v2/everything?q=#{query}&apiKey=#{ENV['NEWS_API_KEY']}")
      response['articles'].map do |article|
        {
          'author': article['author'],
          'title': article['title'],
          'description': article['description'],
          'url': article['url'],
          'urlToImage': article['urlToImage'],
          'publishedAt': article['publishedAt']
        }
      end
    end
  end
end