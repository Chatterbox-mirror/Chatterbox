module GitCafe
  module Request
    def get(path, params={})
      response = RestClient.get(api_endpoint + path, { params: params })
      JSON.parse(response).symbolize_keys
    end
  end
end
