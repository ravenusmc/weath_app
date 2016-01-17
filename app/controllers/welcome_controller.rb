class WelcomeController < ApplicationController

  def index
    #states will need to be defined and then @states.sort will sort all of them on the form. 
    @states = %w(HI AK CA OR WA ID UT NV AZ NM CO WY MT ND SD NE KS OK TX LA AR MO IA MN WI IL IN MI OH KY TN MS AL GA FL SC NC VA WV DE MD PA NY NJ CT RI MA VT NH ME DC PR)
    @states.sort!

    #Here is the call to the API 
    response = HTTParty.get("http://api.wunderground.com/api/#{ENV['wunderground_api_key']}/geolookup/conditions/q/#{params[:state]}/#{params[:city]}.json")
    
      @location = response['location'] ? response['location']['city'] : nil
      @temp_f = response['current_observation'] ? response['current_observation']['temp_f'] : nil
      @temp_c = response['current_observation'] ? response['current_observation']['temp_c'] : nil
      @weather_icon = response['current_observation'] ? response['current_observation']['icon_url'] : nil
      @weather_words = response['current_observation'] ? response['current_observation']['weather'] : nil
      @forecast_link = response['current_observation'] ? response['current_observation']['forecast_url'] : nil
      @real_feel = response['current_observation'] ? response['current_observation']['feelslike_f'] : nil 

      #This part of the code will change the background depending on what @weather_words is. 
      #Head over to the views/layouts/application.html.erb file to see more. 
      if @weather_words == "Partly Cloudy" || @weather_words == "Mostly Cloudy"
        @body_class = "partly-cloudy"
      elsif @weather_words == "Cloudy" || @weather_words == "Scattered Clouds" || @weather_words == "Overcast"
        @body_class = "partly-cloudy" 
      elsif @weather_words == "Clear"
        @body_class = "sunny"
      elsif @weather_words == "snow"
        @body_class = "snow"
      elsif @weather_words == "Rain"
        @body_class = "rain"
      elsif @weather_words == "Fog"
        @body_class = "fog"
      elsif @weather_words == "Thunderstorms and Rain" || @weather_words == "Thunderstorms"
        @body_class = "thunder"
      end
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
