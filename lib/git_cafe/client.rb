require_relative 'request'

require_relative 'client/users'

module GitCafe
  class Client
    def api_endpoint
      http_or_https = ENV['HTTP_OR_HTTPS'] || 'http'
      gitcafe_server = ENV['GITCAFE_SERVER'] || 'gitcafe.com'
      "#{http_or_https}://#{gitcafe_server}/api/v1"
    end

    def token
      ENV['CHATTERBOX_TOKEN']
    end

    include GitCafe::Request

    include GitCafe::Client::Users
  end
end
