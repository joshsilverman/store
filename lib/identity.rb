require 'omniauth/strategies/oauth2'

module OmniAuth
  module Strategies
    class Identity < OmniAuth::Strategies::OAuth2
      studyegg_config_file = File.join(Rails.root,'config','studyegg.yml')
      raise "#{studyegg_config_file} is missing!" unless File.exists? studyegg_config_file
      studyegg_config = YAML.load_file(studyegg_config_file)[Rails.env].symbolize_keys
      
      option :client_options, { :site => studyegg_config[:auth] }

      uid { raw_info['uid'] }
      info { raw_info['info'] }
      extra { {:raw_info => raw_info} }

      def raw_info
        @raw_info ||= access_token.get("/oauth/user.json?oauth_token=#{access_token.token}").parsed
      end
    end
  end
end
