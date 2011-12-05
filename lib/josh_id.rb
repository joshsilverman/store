require 'omniauth/strategies/oauth2'

module OmniAuth
  module Strategies
    class JoshId < OmniAuth::Strategies::OAuth2
      option :client_options, { :site => 'http://localhost:3000' }

      uid { raw_info['uid'] }
      info { raw_info['info'] }
      extra { {'admin' => raw_info['admin'], 'raw_info' => raw_info} }

      def raw_info
        @raw_info ||= access_token.get("/auth/josh_id/user.json?oauth_token=#{access_token.token}").parsed
      end
    end
  end
end
