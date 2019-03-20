require 'httparty'

module Api
  class News
    def fetch(query:)
      response = HTTParty.get("https://newsapi.org/v2/everything?q=#{query}&apiKey=d229b4df87944e9eae8ca6a13ca59607")
      
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