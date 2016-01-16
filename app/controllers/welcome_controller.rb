class WelcomeController < ApplicationController

  def index
    #states will need to be defined
    @states = %w(HI AK CA OR WA ID UT NV AZ NM CO WY MT ND SD NE KS OK TX LA AR MO IA MN WI IL IN MI OH KY TN MS AL GA FL SC NC VA WV DE MD PA NY NJ CT RI MA VT NH ME DC PR)
    @states.sort!

    response = HTTParty.get("http://api.wunderground.com/api/#{ENV['wunderground_api_key']}/geolookup/conditions/q/#{params[:state]}/#{params[:city]}.json")
    
    @location = response['location']['city']
    @temp_f = response['current_observation']['temp_f']
    @temp_c = response['current_observation']['temp_c']
    @weather_icon = response['current_observation']['icon_url']
    @weather_words = response['current_observation']['weather']
    @forecast_link = response['current_observation']['forecast_url']
    @real_feel = response['current_observation']['feelslike_f']
  end

  def test
    #The below line gets the response from the API at the below web address and saves it as the variable response.
    response = HTTParty.get("http://api.wunderground.com/api/#{ENV['wunderground_api_key']}/geolookup/conditions/q/GA/Atlanta.json")

    #Response then pulls out the required information from the JSON data and saves it as an instance variable. 
    @location = response['location']['city']
    @temp_f = response['current_observation']['temp_f']
    @temp_c = response['current_observation']['temp_c']  
    @real_feel = response['current_observation']['feelslike_f']
  end


  
end
