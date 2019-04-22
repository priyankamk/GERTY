# frozen_string_literal: true

require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  render_views

  let(:luis_response) do
    {
      'query' => query_string,
      'topScoringIntent' => {
        'intent' => current_intent
      },
      'entities' => [
        {
          'entity' => current_entity
        }
      ]
    }
  end
  let(:current_intent) { 'Weather' }
  let(:current_entity) { 'melbourne' }
  let(:query_string) { 'weather in melbourne' }

  before do
    stub_request(:get, "https://westus.api.cognitive.microsoft.com/luis/v2.0/apps/99dd0e0c-a5af-4e6d-bde0-75b12247da4e?q=#{query_string}&subscription-key=#{ENV['INTENT_RECOGNIZER_API_KEY']}&timezoneOffset=-360&verbose=true")
      .with(
        headers: {
          'Accept' => '*/*',
          'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'User-Agent' => 'Ruby'
        }
      )
      .to_return(status: 200, body: JSON.dump(luis_response), headers: { 'Content-Type': 'application/json' })
  end

  describe 'GET #index' do
    it 'returns http success' do
      get :index
      expect(response).to have_http_status(:success)
    end

    context 'when query params is weather' do
      let(:query_string) { 'weather in melbourne' }
      let(:current_intent) { 'Weather' }
      let(:current_entity) { 'melbourne' }

      let(:geocoder_response) do
        {
          'results' => [
            'geometry' => {
              'lat' => -37.8142176,
              'lng' => 144.9631608
            }
          ]
        }
      end

      let(:darksky_response) do
        {
          'timezone' => 'Australia/Melbourne',
          'currently' => {
            'temperature' => 66.83,
            'summary' => 'Clear',
            'icon' => 'clear-day'
          }
        }
      end

      before do
        stub_request(:get, "https://api.opencagedata.com/geocode/v1/json?key=#{ENV['GEOCODER_API_KEY']}&q=#{current_entity}")
          .with(
            headers: {
              'Accept' => '*/*',
              'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
              'User-Agent' => 'Ruby'
            }
          )
          .to_return(status: 200, body: JSON.dump(geocoder_response), headers: { 'Content-Type': 'application/json' })

        stub_request(:get, "https://api.darksky.net/forecast/#{ENV['WEATHER_API_KEY']}/-37.8142176,144.9631608?units=si")
          .with(
            headers: {
              'Accept' => '*/*',
              'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
              'User-Agent' => 'Ruby'
            }
          )
          .to_return(status: 200, body: JSON.dump(darksky_response), headers: { 'Content-Type': 'application/json' })
      end

      it 'creates a new history record' do
        get :index, params: { query: query_string }

        expect(History.last.query).to eq(query_string)
      end

      it 'shows weather for australia/melbourne' do
        get :index, params: { query: query_string }

        expect(response.body).to include('Australia/Melbourne')
      end
    end

    context 'when query params is giphy' do
      let(:query_string) { 'show me rainbow cat giphy' }
      let(:current_entity) { 'rainbow cat' }
      let(:current_intent) { 'Giphy' }

      let(:giphy_response) do
        {
          'data' =>
          [
            {
              'slug' => 'funny-animation-art-5jWeEENNyVln9vrnoP',
              'images' => {
                'original' => {
                  'url' => 'https://media3.giphy.com/media/5jWeEENNyVln9vrnoP/giphy.gif'
                }
              }
            }
          ]
        }
      end

      before do
        stub_request(:get, "http://api.giphy.com/v1/gifs/search?api_key=#{ENV['GIPHY_API_KEY']}&limit=15&offset=2&q=#{current_entity}")
          .with(
            headers: {
              'Accept' => '*/*',
              'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
              'User-Agent' => 'Ruby'
            }
          )
          .to_return(status: 200, body: JSON.dump(giphy_response), headers: { 'Content-Type': 'application/json' })
      end

      it 'creates a new history record' do
        get :index, params: { query: query_string }
        expect(History.last.query).to eq(query_string)
      end

      it 'shows for giphy images' do
        get :index, params: { query: query_string }
        expect(response.body).to include('https://media3.giphy.com/media/5jWeEENNyVln9vrnoP/giphy.gif')
      end
    end

    context 'when query params is movie' do
      let(:query_string) { 'show me the list of avengers movie' }
      let(:current_entity) { 'avengers' }
      let(:current_intent) { 'Movie' }

      let(:movie_response) do
        {
          'Search' =>
          [
            {
              'Title' => 'The Avengers',
              'imdbID' => 'tt0848228'
            }
          ]
        }
      end

      before do
        stub_request(:get, "http://www.omdbapi.com/?apikey=#{ENV['MOVIE_API_KEY']}&s=#{current_entity}")
          .with(
            headers: {
              'Accept' => '*/*',
              'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
              'User-Agent' => 'Ruby'
            }
          )
          .to_return(status: 200, body: JSON.dump(movie_response), headers: { 'Content-Type': 'application/json' })
      end

      it 'creates a new history record' do
        get :index, params: { query: query_string }
        expect(History.last.query).to eq(query_string)
      end

      it 'show for movie title' do
        get :index, params: { query: query_string }
        expect(response.body).to include('The Avengers')
      end
    end

    context 'when query params is quote' do
      let(:query_string) { 'motivation quote' }
      let(:current_entity) { 'motivation' }
      let(:current_intent) { 'Quote' }

      let(:quote_response) do
        {
          'contents' =>
          {
            'quote' => " My motivation comes from the Lord. My favorite verse is, 'Whatever you do, work at it with all your heart, as working for the Lord, not for men ...' (Colossians 3:23). As long as that remains my motivation I can always work hard.",
            'author' => 'Stephen McDowell'
          }
        }
      end

      before do
        stub_request(:get, "http://quotes.rest/quote/search?minlength=100&maxlength=300&query=#{current_entity}&private=false")
          .with(
            headers: {
              # 'Accept'=>'*/*',
              # 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
              # 'User-Agent'=>'Ruby',
              'X-TheySaidSo-Api-Secret': ENV['QUOTE_API_KEY']
            }
          ).to_return(status: 200, body: JSON.dump(quote_response), headers: { 'Content-Type': 'application/json' })
      end

      it 'creates a new history record' do
        get :index, params: { query: query_string }
        expect(History.last.query).to eq(query_string)
      end
    end

    context 'when query params is news' do
      let(:query_string) { 'latest brexit news' }
      let(:current_entity) { 'brexit' }
      let(:current_intent) { 'News' }

      let(:news_response) do
        {
          'articles' => [
            {
              'author' => 'BENJAMIN MUELLER and PALKO KARASZ',
              'title' => 'Britons Set to March in London to Demand Second Brexit Vote',
              'description' => 'Anti-Brexit campaigners outside Parliament in London this month. A march on Saturday is calling for a “People’s Vote” on Brexit.',
              'url' => 'https://www.nytimes.com/2019/03/23/world/europe/brexit-march-london.html',
              'urlToImage' => 'https://static01.nyt.com/images/2019/03/23/world/23march1/23march1-facebookJumbo.jpg'
            }
          ]
        }
      end

      before do
        stub_request(:get, "https://newsapi.org/v2/everything?apiKey=#{ENV['NEWS_API_KEY']}&q=#{current_entity}")
          .with(
            headers: {
              'Accept' => '*/*',
              'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
              'User-Agent' => 'Ruby'
            }
          )
          .to_return(status: 200, body: JSON.dump(news_response), headers: { 'Content-Type': 'application/json' })
      end

      it 'creates a new history record' do
        get :index, params: { query: query_string }
        expect(History.last.query).to eq(query_string)
      end
    end
  end
end
