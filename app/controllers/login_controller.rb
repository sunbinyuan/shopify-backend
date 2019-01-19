class LoginController < ApplicationController
    skip_before_action :verify_authenticity_token

    def login
        render json: AccessToken.create!().to_json(only: [:access_token])
    end

    def logout
        access_token = params[:access_token]

        at = AccessToken.find_by({access_token: access_token})
        at.destroy if !at.nil?
        render json: {}

    end
end
