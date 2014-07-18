require 'net/http'
require 'openssl'
require 'json'

# The NationalCrimeSearh class is a wrapper for the API provided by NCS.
# It supports the 8 provided endpoints for submitting new searches, generating
# and validating user tokens, getting the status of searches, and getting the
# search packages and their inputs.
class NationalCrimeSearch
  attr_accessor :token, :root_uri, :username, :password, :test_environment,
                :endpoints

  # username: your email address used to login to NCS
  # token: the api token found on the account info page after logging in to NCS
  # test_env: If this is set to true, all calls will be made to
  #           api-test.nationalcrimesearch.com and ssl will not validate the
  #           certificates.
  def initialize(username, token, test_env = false)
    @username = username
    @token = token
    @test_environment = test_env
    @root_uri = get_root_uri(test_env)
    @endpoints = [:valid_token, :generate_token, :valid_user, :searches,
                  :show_search]
  end

  # The target is a symbol or string for the path action. 
  # Examples:
  #    :valid_token, :generate_token, :searches, :show_search
  def send_request(target, payload = {})
    if valid_endpoint?(target)
      send_post(get_path_for_endpoint(target), payload)
    else
      { 'error' => "#{target} is not a valid endpoint" }
    end
  end

  # Convenience method for accessing whether you are setup for test or not
  def test_env?
    @test_environment
  end

  private

  def get_root_uri(test_env)
    if test_env
      URI.parse('https://api-test.nationalcrimesearch.com/api/')
    else
      URI.parse('https://api.nationalcrimesearch.com/api/')
    end
  end

  # Returns the path for the endpoint so the user doesn't have to provide it
  # themselves
  def get_path_for_endpoint(target, args = {})
    case target
    when :valid_token, :generate_token then
      "/users/#{target}.json"
    when :valid_user then
      '/users/valid.json'
    else
      "/searches/#{target}.json"
    end
  end

  # Verifies the endpoint is a supported endpoint by the class
  def valid_endpoint?(target)
    endpoints.include? target
  end

  # Should only be called if the endpoint is validated.
  # The payload is a hash of the form data to post. All calls to the
  # API require the user token, so it can be omitted. If it is provided,
  # the method will not attempt to add it. This allows a user to check or 
  # use a different token.
  def send_post(endpoint, payload = {})
    payload['token'] = @token unless payload['token']
    http = Net::HTTP.new(@root_uri.host, @root_uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE if @test_environment
    request = Net::HTTP::Post.new("#{@root_uri}#{endpoint}")
    request.set_form_data(payload)
    process_response(http.request(request))
  end

  # The response will return a hash. Read the NCS API documentation to
  # determine what keys will be available for each endpoint.
  # If errors are returned, you can check for an error key in the hash
  # and handle it appropriately.
  def process_response(response)
    case response
    when Net::HTTPSuccess
      JSON.parse response.body
    when Net::HTTPUnauthorized
      { 'error' => "#{response.message}:
                   username and password set and correct?" }
    when Net::HTTPServerError
      { 'error' => "#{response.message}: try again later?" }
    else
      { 'error' => response.message }
    end
  end
end
