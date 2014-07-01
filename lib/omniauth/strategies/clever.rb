require 'omniauth-oauth2'
require 'base64'

module OmniAuth
  module Strategies
    class Clever < OmniAuth::Strategies::OAuth2
      option :name, "clever"

      option :client_options, {
        :site          => 'https://api.clever.com',
        :authorize_url => 'https://account.clever.com/oauth/authorize',
        :token_url     => 'https://api.clever.com/oauth/token'
      }

      def authorize_params
        super.tap do |params|
          params[:scope] = 'read_only'
          params[:clever_landing] = options.client_options.clever_landing || 'admin'
          if options.client_options.dev
            params[:dev] = options.client_options.dev
          end
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
        { :user_type => raw_info['type'] }.merge! raw_info['data']
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