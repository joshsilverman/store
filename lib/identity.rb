require 'omniauth/strategies/oauth2'

module OmniAuth
  module Strategies
    class Identity < OmniAuth::Strategies::OAuth2
      option :client_options, { :site => STUDYEGG_USER_MANAGER_PATH }

      uid { raw_info['uid'] }
      info { raw_info['info'] }
      extra { {:raw_info => raw_info} }

      def raw_info
        @raw_info ||= access_token.get("/oauth/user.json?oauth_token=#{access_token.token}").parsed
      end
    end
  end
end
