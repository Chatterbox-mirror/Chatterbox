require_relative 'client'

module GitCafe
  class << self
    def method_missing(method, *args, &block)
      GitCafe::Client.new.send(method, *args, &block)
    end
  end
end
