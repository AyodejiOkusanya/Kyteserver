class ApplicationController < ActionController::API

    def kyte_api_key
        ENV['KYTE_API_KEY']
    end 
end
