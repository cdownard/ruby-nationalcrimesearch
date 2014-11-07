require 'spec_helper'

describe 'configuration' do
  describe '.token' do
    it 'should return the default token' do
      expect(NationalCrimeSearch.token).to(
        eq(NationalCrimeSearch::Configuration::DEFAULT_USER_TOKEN))
    end
  end

  describe '.method' do
    it 'should return the default method' do
      expect(NationalCrimeSearch.method).to(
        eq(NationalCrimeSearch::Configuration::DEFAULT_METHOD))
    end
  end

  describe '.endpoint' do
    it 'should return the default endpoint' do
      expect(NationalCrimeSearch.endpoint).to(
        eq(NationalCrimeSearch::Configuration::DEFAULT_ENDPOINT))
    end
  end

  describe '.format' do
    it 'should return the default format' do
      expect(NationalCrimeSearch.format).to(
        eq(NationalCrimeSearch::Configuration::DEFAULT_FORMAT))
    end
  end

  describe '.configure' do
    NationalCrimeSearch::Configuration::VALID_CONFIG_KEYS.each do |key|
      it "should set the #{key}" do
        NationalCrimeSearch.configure do |config|
          config.send("#{key}=", key)
          expect(key).to eq(NationalCrimeSearch.send(key))
        end
      end
    end
  end
end
