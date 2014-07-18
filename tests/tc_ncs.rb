require_relative '../ncs'
require 'test/unit'

# Suite of tests for NationalCrimeSearch
class TestNCS < Test::Unit::TestCase
  def setup
    @token = 'a_token'
    @username = 'a_username@email.com'
    @ncs = NationalCrimeSearch.new(@username, @token, true)
  end

  # constructor
  def test_initialize_test_environment
    test_client = NationalCrimeSearch.new(@username, @token, true)
    assert_equal true, test_client.test_env?
    assert_equal true, test_client.root_uri.to_s.include?('//api-test.')

    test_client = NationalCrimeSearch.new(@username, @token)
    assert_equal false, test_client.test_env?
    assert_equal true, test_client.root_uri.to_s.include?('//api.')
  end

  # public method tests
  def test_test_env?
    assert_equal true, @ncs.test_env?

    test_client = NationalCrimeSearch.new(@username, @token)
    assert_equal false, test_client.test_env?
  end

  # Private method tests
  def test_get_root_uri
    result = @ncs.send(:get_root_uri, @ncs.test_environment)
    assert_equal 'https://api-test.nationalcrimesearch.com/api/', result.to_s

    test_client = NationalCrimeSearch.new(@username, @token)
    result = test_client.send(:get_root_uri, test_client.test_environment)
    assert_equal 'https://api.nationalcrimesearch.com/api/', result.to_s
  end

  def test_get_path_for_endpoint
    result = @ncs.send(:get_path_for_endpoint, :valid_token)
    assert_equal '/users/valid_token.json', result

    result = @ncs.send(:get_path_for_endpoint, :generate_token)
    assert_equal '/users/generate_token.json', result
  end
end
