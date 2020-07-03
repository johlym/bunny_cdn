require 'spec_helper'

RSpec.describe BunnyCdn::Storage do
  before(:each) do
    BunnyCdn.configure do |config|
      config.storage_zone = ENV['STORAGE_ZONE']
      config.access_key = ENV['ACCESS_KEY']
    end
    headers = {
      :access_key => BunnyCdn.configuration.access_key
    }
  end

  describe "#getAllFiles" do
    before do
      stub_request(:get, "https://storage.bunnycdn.com/#{BunnyCdn.configuration.storage_zone}/#{ENV['FILE_PATH']}").
        with(
          headers: {
            :access_key => BunnyCdn.configuration.access_key
          }).
        to_return(status: 200, body: "")
    end
    it "gets all files from storage zone" do
      headers = {
        :access_key => BunnyCdn.configuration.access_key
      }
      BunnyCdn::Storage.getZoneFiles
      # RestClient.get("https://storage.bunnycdn.com/#{BunnyCdn.configuration.storage_zone}/", headers)
      expect(WebMock).to have_requested(:get ,"https://storage.bunnycdn.com/#{BunnyCdn.configuration.storage_zone}/").
        with(headers: {
          :access_key => BunnyCdn.configuration.access_key
        }).once
    end
  end

  describe "#getFile" do
    before do
      file = 'test_file.txt'
      stub_request(:get, "https://storage.bunnycdn.com/#{BunnyCdn.configuration.storage_zone}/#{ENV['FILE_PATH']}/#{file}").
        with(
          headers: {
            :access_key => BunnyCdn.configuration.access_key
          }).
        to_return(status: 200)
    end
    it "gets a single file from the storage zone" do
      headers = {
        :access_key => BunnyCdn.configuration.access_key
      }
      path = ENV['FILE_PATH']
      file = 'test_file.txt'
      BunnyCdn::Storage.getFile(path, file)
      expect(WebMock).to have_requested(:get ,"https://storage.bunnycdn.com/#{BunnyCdn.configuration.storage_zone}/#{path}/#{file}").
        with(headers: {
          :access_key => BunnyCdn.configuration.access_key
        }).once
    end
  end

  describe "#uploadFile" do
    before do
      file = File.join('spec', 'test_file.txt')
      stub_request(:put, "https://storage.bunnycdn.com/#{BunnyCdn.configuration.storage_zone}/#{ENV['FILE_PATH']}/#{File.basename(file)}").
        with(
          headers: {
            :access_key => BunnyCdn.configuration.access_key,
            :checksum => ''
          },
          body: File.read(file)).
        to_return(status: 200)
    end
    it "uploads file to storage zone" do
      headers = {
        :access_key => BunnyCdn.configuration.access_key,
        :checksum => ''
      }
      path = ENV['FILE_PATH']
      file = File.join('spec', 'test_file.txt')
      # BunnyCdn::Storage.uploadFile(path, file)
      RestClient.put("https://storage.bunnycdn.com/#{BunnyCdn.configuration.storage_zone}/#{ENV['FILE_PATH']}/#{File.basename(file)}", File.read(file), headers)
      expect(WebMock).to have_requested(:put ,"https://storage.bunnycdn.com/#{BunnyCdn.configuration.storage_zone}/#{ENV['FILE_PATH']}/#{File.basename(file)}").
        with(headers: {
          :access_key => BunnyCdn.configuration.access_key,
          :checksum => ''
        }).once
    end
  end

  # describe "#deleteFile" do
  #   before do
  #     stub_request(:delete, "https://storage.bunnycdn.com/#{BunnyCdn.configuration.storage_zone}/#{ENV['FILE_PATH']}/#{ENV['FILE_NAME']}").
  #       with(
  #         headers: {
  #           :access_key => BunnyCdn.configuration.access_key
  #         }).
  #         to_return(status: 200)
  #   end
  #   it "deletes file to storage zone" do
  #     headers = {
  #       :access_key => BunnyCdn.configuration.access_key
  #     }
  #     path = ENV['FILE_PATH']
  #     file = ENV['FILE_NAME']
  #     BunnyCdn::Storage.deleteFile(path, file)
  #     expect(WebMock).to have_requested(:delete ,"https://storage.bunnycdn.com/#{BunnyCdn.configuration.storage_zone}/#{ENV['FILE_PATH']}/#{ENV['FILE_NAME']}").
  #       with(headers: {
  #         :access_key => BunnyCdn.configuration.access_key
  #       }).once
  #   end
  # end
end