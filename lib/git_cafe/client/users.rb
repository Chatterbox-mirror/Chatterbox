module GitCafe
  class Client
    module Users
      def avatar_url(username, params={})
        get("/users/#{username}/avatar_url", params)[:avatar_url]
      end
    end
  end
end
