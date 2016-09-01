require 'omniauth-oauth2'
require 'base64'

module OmniAuth
  module Strategies
    class Clever < OmniAuth::Strategies::OAuth2
      # Clever is a unique OAuth 2.0 service provider in that login sequences
      # are often initiated by Clever, not the client. When Clever initiates
      # login, a state parameter is not relevant nor sent.

      option :name, "clever"
      option :client_options, {
        :site          => 'https://api.clever.com',
        :authorize_url => 'https://clever.com/oauth/authorize',
        :token_url     => 'https://clever.com/oauth/tokens'
      }

      option :get_user_info, false

      # This option bubbles up to the OmniAuth::Strategies::OAuth2
      # when we call super in the callback_phase below.
      # **State will still be verified** when login is initiated by the client.
      option :provider_ignores_state, true

      def token_params
        super.tap do |params|
          params[:headers] = {'Authorization' => "Basic #{Base64.strict_encode64("#{options.client_id}:#{options.client_secret}")}"}
        end
      end

      def callback_phase
        error = request.params["error_reason"] || request.params["error"]
        stored_state = session.delete("omniauth.state")
        if error
          fail!(error, CallbackError.new(request.params["error"], request.params["error_description"] || request.params["error_reason"], request.params["error_uri"]))
        else
          # Only verify state if we've initiated login and have stored a state
          # to compare to.
          if stored_state && (!request.params["state"] || request.params["state"] != stored_state)
            fail!(:csrf_detected, CallbackError.new(:csrf_detected, "CSRF detected"))
          else
            super
          end
        end
      end

      uid{ raw_info['data']['id'] }

      info do
        { :user_type => raw_info['type'] }.merge(raw_info['data']).merge(raw_user_info['data'])
      end

      extra do
        {
          'raw_info' => raw_info,
          'raw_user_info' => raw_user_info
        }
      end

      def raw_info
        @raw_info ||= access_token.get('/me').parsed
      end

      def raw_user_info
        return @raw_user_info if @raw_user_info

        @raw_user_info = {}

        if options.get_user_info
          user_type = raw_info['type']
          user_id = raw_info['data']['id']
          if user_type && user_id
            @raw_user_info = access_token.get("/v1.1/#{user_type}s/#{user_id}").parsed
          end
        end

        @raw_user_info
      end
    end
  end
end
