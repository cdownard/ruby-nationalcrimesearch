module NationalCrimeSearch
  module Configuration
    VALID_CONNECTION_KEYS = [:endpoint, :user_agent, :method].freeze
    VALID_OPTIONS_KEYS = [:token, :format].freeze
    VALID_CONFIG_KEYS = VALID_CONNECTION_KEYS + VALID_OPTIONS_KEYS

    DEFAULT_ENDPOINT = 'http://nationalcrimesearch.com/api'
    DEFAULT_METHOD = :get
    DEFAULT_USER_AGENT = "National Crime Search Ruby Gem #{NationalCrimeSearch::VERSION}".freeze

    DEFAULT_USER_TOKEN = nil
    DEFAULT_FORMAT = :json

    attr_accessor *VALID_CONFIG_KEYS

    def self.extended(base)
      base.reset
    end

    def configure
      yield self
    end

    def reset
      self.endpoint = DEFAULT_ENDPOINT
      self.method = DEFAULT_METHOD
      self.user_agent = DEFAULT_USER_AGENT

      self.token = DEFAULT_USER_TOKEN
      self.format = DEFAULT_FORMAT
    end
  end
end
