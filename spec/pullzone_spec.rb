require 'spec_helper'

RSpec.describe BunnyCdn::Pullzone do
  before(:each) do
    BunnyCdn.configure do |config|
      config.api_key = ENV['API_KEY']
    end
    headers = 
    {
      :content_type => 'application/json', 
      :accept => 'application/json',
      :access_key => BunnyCdn.configuration.api_key
    }
  end

  describe "#getAllPullzones" do
    before do
      stub_request(:get, "https://bunnycdn.com/api/pullzone").
        with(
          headers: {
            :content_type => 'application/json',
            :accept => 'application/json',
            :access_key => BunnyCdn.configuration.api_key
          }).to_return(status: 200)
    end
    it "gets all pullzones" do
      BunnyCdn::Pullzone.getAllPullzones
      expect(WebMock).to have_requested(:get, "https://bunnycdn.com/api/pullzone").
        with(headers: {
        :content_type => 'application/json', 
        :accept => 'application/json',
        :access_key => BunnyCdn.configuration.api_key
        }).once
    end
  end

  describe "#createPullzone" do
    before do
      stub_request(:post, "https://bunnycdn.com/api/pullzone").
        with(
          headers: {
            :content_type => 'application/json',
            :accept => 'application/json',
            :access_key => BunnyCdn.configuration.api_key
          },
          body: {
            :name => 'test',
            :type => 0,
            :originUrl => 'http://example.com'
          }).to_return(status: 200)
    end
    it "gets all pullzones" do
      BunnyCdn::Pullzone.createPullzone('test', 0, 'http://example.com')
      expect(WebMock).to have_requested(:post, "https://bunnycdn.com/api/pullzone").
      with(
        headers: {
          :content_type => 'application/json',
          :accept => 'application/json',
          :access_key => BunnyCdn.configuration.api_key
        },
        body: {
          :name => 'test',
          :type => 0,
          :originUrl => 'http://example.com'
        }).once
    end
  end

  describe "#getSinglePullzone" do
    before do
      stub_request(:get, "https://bunnycdn.com/api/pullzone/1234").
        with(
          headers: {
            :content_type => 'application/json',
            :accept => 'application/json',
            :access_key => BunnyCdn.configuration.api_key
          }).to_return(status: 200)
    end
    it "gets a single pullzone by ID" do
      BunnyCdn::Pullzone.getSinglePullzone(1234)
      expect(WebMock).to have_requested(:get, "https://bunnycdn.com/api/pullzone/1234").
      with(
        headers: {
          :content_type => 'application/json',
          :accept => 'application/json',
          :access_key => BunnyCdn.configuration.api_key
        }).once
    end
  end

  describe "#deletePullzone" do
    before do
      stub_request(:delete, "https://bunnycdn.com/api/pullzone/1234").
      with(headers: {
        :content_type => 'application/json',
        :accept => 'application/json',
        :access_key => BunnyCdn.configuration.api_key
      }).to_return(status: 200)
    end
    it "deletes pullzone by ID" do
      BunnyCdn::Pullzone.deletePullzone(1234)
      expect(WebMock).to have_requested(:delete, "https://bunnycdn.com/api/pullzone/1234").
      with(headers: {
        :content_type => 'application/json',
        :accept => 'application/json',
        :access_key => BunnyCdn.configuration.api_key
      }).once
    end
  end

  describe "#purgeCache" do
    before do
      stub_request(:post, "https://bunnycdn.com/api/pullzone/1234/purgeCache").
        with(headers: {
          :content_type => 'application/json',
          :accept => 'application/json',
          :access_key => BunnyCdn.configuration.api_key
        }).to_return(status: 200)
    end
    it "purges cache for the specified pullzone" do
      BunnyCdn::Pullzone.purgeCache(1234)
    end
  end
end