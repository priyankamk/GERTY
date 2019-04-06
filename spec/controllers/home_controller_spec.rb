require 'rails_helper'

RSpec.describe HomeController, type: :controller do
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
  let(:current_intent) {'Weather'}
  let(:current_entity) {'melbourne'}
  let(:query_string) { 'weather in melbourne' }

  before do
    stub_request(:get, "https://westus.api.cognitive.microsoft.com/luis/v2.0/apps/99dd0e0c-a5af-4e6d-bde0-75b12247da4e?q=#{query_string}&subscription-key=#{ENV['INTENT_RECOGNIZER_API_KEY']}&timezoneOffset=-360&verbose=true").
         with(
           headers: {
          'Accept'=>'*/*',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'User-Agent'=>'Ruby'
           }).
         to_return(status: 200, body: JSON.dump(luis_response), headers: {'Content-Type': 'application/json'})
  end

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end

    context "when query params is weather" do
      let(:query_string) { 'weather in melbourne' }

      let(:geocoder_response) do
        {
          'results' => [
            'geometry' => {
              "lat" => -37.8142176,
              "lng" => 144.9631608
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
        stub_request(:get, "https://api.opencagedata.com/geocode/v1/json?key=#{ENV['GEOCODER_API_KEY']}&q=melbourne").
          with(
             headers: {
            'Accept'=>'*/*',
            'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
            'User-Agent'=>'Ruby'}).
          to_return(status: 200, body: JSON.dump(geocoder_response), headers: {'Content-Type': 'application/json'})

        stub_request(:get, "https://api.darksky.net/forecast/#{ENV['WEATHER_API_KEY']}/#{-37.8142176.to_s},#{144.9631608.to_s}?units=si").
        with(
            headers: {
          'Accept'=>'*/*',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'User-Agent'=>'Ruby'}).
        to_return(status: 200, body: JSON.dump(darksky_response), headers: {'Content-Type': 'application/json'})
      end

      it "creates a new history record" do
        get :index, params: {query: query_string}

        expect(History.last.query).to eq(query_string)
      end  
    end

    context "when query params is giphy" do
      let(:query_string) {'show me rainbow cat giphy' }
      let(:current_entity) { 'rainbow cat' }
      let(:current_intent) { 'Giphy' }

      let(:giphy_response) do
        {
          'data' => 
          [
            {
              'slug' => 'funny-animation-art-5jWeEENNyVln9vrnoP'
            },
            'images' => {
              'original' => {
                'url' => 'https://media3.giphy.com/media/5jWeEENNyVln9vrnoP/giphy.gif'
              }
            }
          ]
        }
      end

      before do 
        stub_request(:get, "http://api.giphy.com/v1/gifs/search?api_key=#{ENV['GIPHY_API_KEY']}&limit=15&offset=2&q=rainbow%20cat").
          with(
            headers: {
              'Accept'=>'*/*',
              'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
              'User-Agent'=>'Ruby'}).
              to_return(status: 200, body: JSON.dump(giphy_response), headers: {'Content-Type': 'application/json'})
      end

      it 'create a new history record' do
        get :index, params: {query: query_string}
        expect(History.last.query).to eq(query_string)
      end
    end
    
  end
end