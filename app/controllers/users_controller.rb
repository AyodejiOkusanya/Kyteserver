require 'rest-client'

class UsersController < ApplicationController

   


    def get_offers 
        payload = {
            "journeys": [
                {
                    "departureAirport": "LHR",
                    "arrivalAirport": "HKG",
                    "departureDate": "2019-04-05",
                    "ticketTypes": [
                        "economy"
                    ]
                },
                {
                    "departureAirport": "HKG",
                    "arrivalAirport": "LHR",
                    "departureDate": "2019-04-10",
                    "ticketTypes": [
                        "economy"
                    ]
                }
            ],
            "passengers": [
                {
                    "type": "adult"
                },
                {
                    "type": "adult"
                }
            ]
        }

response = RestClient::Request.new({
  method: :post,
  url: 'https://sandbox.api.gokyte.com/api/flights/search',
  payload: payload.to_json,
  headers: {content_type: 'application/json', "x-api-key": ENV['KYTE_API_KEY']}
   }).execute do |response, request, result|
  case response.code
  when 400
    [ :error, JSON.parse(response.to_str) ]
  when 200
    [ :success, JSON.parse(response.to_str) ]
  else
    fail "Invalid response #{response.to_str} received."
  end
end
render json: response 
end 


def make_booking
    payload = {"offerId": params[:offerId] }
    response = RestClient::Request.new({
        method: :post,
        url: 'https://sandbox.api.gokyte.com/api/flights/offer',
        payload: payload.to_json,
        headers: {content_type: 'application/json', "x-api-key": ENV['KYTE_API_KEY']}
   }).execute do |response, request, result|
  case response.code
  when 400
    [ :error, JSON.parse(response.to_str) ]
  when 200
    [ :success, JSON.parse(response.to_str) ]
  else
    fail "Invalid response #{response.to_str} received."
  end
end
render json: response 

end 

    
end
