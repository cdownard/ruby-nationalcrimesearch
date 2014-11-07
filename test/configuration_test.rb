require 'helper'

describe 'configuration' do
  describe '.token' do
    it 'should return the default token' do
      NationalCrimeSearch.token.must_equal(
        NationalCrimeSearch::Configuration::DEFAULT_USER_TOKEN)
    end
  end

  describe '.method' do
    it 'should return the default method' do
      NationalCrimeSearch.method.must_equal(
        NationalCrimeSearch::Configuration::DEFAULT_METHOD)
    end
  end

  describe '.endpoint' do
    it 'should return the default endpoint' do
      NationalCrimeSearch.endpoint.must_equal(
        NationalCrimeSearch::Configuration::DEFAULT_ENDPOINT)
    end
  end

  describe '.format' do
    it 'should return the default format' do
      NationalCrimeSearch.format.must_equal(
        NationalCrimeSearch::Configuration::DEFAULT_FORMAT)
    end
  end

  after do
    NationalCrimeSearch.reset
  end

  describe '.configure' do
    NationalCrimeSearch::Configuration::VALID_CONFIG_KEYS.each do |key|
      it "should set the #{key}" do
        NationalCrimeSearch.configure do |config|
          config.send("#{key}=", key)
          NationalCrimeSearch.send(key).must_equal key
        end
      end
    end
  end
end
