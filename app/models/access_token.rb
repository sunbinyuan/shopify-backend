require 'securerandom'

class AccessToken < ApplicationRecord

    def self.validate(access_token)
        at = AccessToken.find_by({access_token: access_token})
        raise InvalidAccessTokenException if at.nil?
    end

    def self.create(attributes = nil)
        attributes = {access_token: generate_alias}.merge(attributes || {})
        return super(attributes)
    end

    def self.create!(attributes = nil)
        attributes = {access_token: generate_alias}.merge(attributes || {})
        return super(attributes)
    end

    def self.generate_alias
      return SecureRandom.hex
    end

    class InvalidAccessTokenException < StandardError

        def initialize
            super("Invalid access token")
        end
    end

end
