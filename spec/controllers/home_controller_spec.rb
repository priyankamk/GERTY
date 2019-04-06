require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  let(:luis_response) do
    {
      'query' => 'weather in melbourne',
      'topScoringIntent' => {
        'intent' => 'Weather'
      },
      'entities' => [
        {
          'entity' => 'melbourne'
        }
      ]
    }
  end
  before do
    stub_request(:get, "https://westus.api.cognitive.microsoft.com/luis/v2.0/apps/99dd0e0c-a5af-4e6d-bde0-75b12247da4e?q=weather%20in%20melbourne&subscription-key=#{ENV['INTENT_RECOGNIZER_API_KEY']}&timezoneOffset=-360&verbose=true").
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

    context "when query params is set" do
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
        get :index, params: {query: 'weather in melbourne'}

        expect(History.last.query).to eq("weather in melbourne")
      end  

      
      
    end
  end
end