class WelcomeController < ApplicationController
  def test
    #The below line gets the response from the API at the below web address and saves it as the variable response.
    response = HTTParty.get("http://api.wunderground.com/api/#{ENV['wunderground_api_key']}/geolookup/conditions/q/GA/Atlanta.json")

    #Response then pulls out the required information from the JSON data and saves it as an instance variable. 
    @location = response['location']['city']
    @temp_f = response['current_observation']['temp_f']
    @temp_c = response['current_observation']['temp_c']  
  end

  def index
  end
end
