require 'omniauth-oauth2'
require 'base64'

module OmniAuth
  module Strategies
    class Clever < OmniAuth::Strategies::OAuth2
      option :name, "clever"

      option :client_options, {
        :site          => 'https://api.getclever.com',
        :authorize_url => 'https://account.getclever.com/oauth/authorize',
        :token_url     => 'https://api.getclever.com/oauth/token'
      }

      def authorize_params
        super.tap do |params|
          params[:scope] = 'read_only'
        end
      end

      def token_params
        username_password = options.client_secret + ":"
        super.tap do |params|
          params[:headers] = {'Authorization' => "Basic #{Base64.encode64(username_password)}"}
        end
      end



      uid{ raw_info['data']['id'] }

      info do
        {
          :name        => raw_info['data']['name'],
          :email       => raw_info['data']['email'],
          :district_id => raw_info['data']['district_id'],
          :name        => raw_info['data']['name'],
          :phone       => raw_info['data']['phone']
        }
      end

      extra do
        {
          'raw_info' => raw_info
        }
      end

      def raw_info
        @raw_info ||= access_token.get('/me').parsed
      end
    end
  end
end