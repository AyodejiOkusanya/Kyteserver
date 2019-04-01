require 'rest-client'

class UsersController < ApplicationController

   


    def get_offers 
        payload = {
            "journeys": [
                {
                    "departureAirport": params[:flightDetails][:departureAirport],
                    "arrivalAirport": params[:flightDetails][:arrivalAirport],
                    "departureDate": params[:flightDetails][:departureDate],
                    "ticketTypes": [
                        params[:flightDetails][:ticketTypes]
                    ]
                },
                {
                    "departureAirport": params[:flightDetails][:arrivalAirport],
                    "arrivalAirport": params[:flightDetails][:departureAirport],
                    "departureDate": params[:flightDetails][:returnDate],
                    "ticketTypes": [
                        params[:flightDetails][:ticketTypes]
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


def confirm_booking
    
    # payload = params[:bookingInfo] 


    payload =  {
        "bookingId": "{{#{params[:bookingInfo][:bookingId]}}}",
        "passengers": [
          {
            "passengerId": params[:bookingInfo][:passengers][0][:passengerId],
            "gender": params[:bookingInfo][:passengers][0][:gender],
            "birthDate": params[:bookingInfo][:passengers][0][:birthDate],
            "title": params[:bookingInfo][:passengers][0][:title],
            "givenName": params[:bookingInfo][:passengers][0][:givenName],
            "surname": params[:bookingInfo][:passengers][0][:surname],
            "type": params[:bookingInfo][:passengers][0][:type],
            "email": params[:bookingInfo][:passengers][0][:email]
          },
          {
            "passengerId": params[:bookingInfo][:passengers][1][:passengerId],
            "gender": params[:bookingInfo][:passengers][1][:gender],
            "birthDate": params[:bookingInfo][:passengers][1][:birthDate],
            "title": params[:bookingInfo][:passengers][1][:title],
            "givenName": params[:bookingInfo][:passengers][1][:givenName],
            "surname": params[:bookingInfo][:passengers][1][:surname],
            "type": params[:bookingInfo][:passengers][1][:type],
            "email": params[:bookingInfo][:passengers][1][:email]
          }
        ],
        "payment": {
            "cardholderName": params[:bookingInfo][:payment][:cardholderName],
            "cardType": params[:bookingInfo][:payment][:cardType],
            "cardNumber": params[:bookingInfo][:payment][:cardNumber],
            "expiryMonth": params[:bookingInfo][:payment][:expiryMonth],
            "expiryYear": params[:bookingInfo][:payment][:expiryYear],
            "issueMonth": params[:bookingInfo][:payment][:issueMonth],
            "issueYear": params[:bookingInfo][:payment][:issueYear],
            "cvv": params[:bookingInfo][:payment][:cvv],
            "contactEmail": params[:bookingInfo][:payment][:contactEmail],
            "address": {
                "addressLine1": params[:bookingInfo][:payment][:address][:addressLine1],
                "addressLine2": params[:bookingInfo][:payment][:address][:addressLine2],
                "addressLine3": params[:bookingInfo][:payment][:address][:addressLine3],
                "city": params[:bookingInfo][:payment][:address][:city],
                "postalCode": params[:bookingInfo][:payment][:address][:postalCode],
                "countryCode": params[:bookingInfo][:payment][:address][:countryCode]
            }
        }
    }












    response = RestClient::Request.new({
        method: :post,
        url: 'https://sandbox.api.gokyte.com/api/flights/book',
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
