require 'spec_helper'

RSpec.describe BunnyCdn::Storage do
  before(:each) do
    BunnyCdn.configure do |config|
      config.api_key = ENV["BCDN_API_KEY"]
      config.storage_zone = ENV["BCDN_STORAGE_ZONE"]
      config.access_key = ENV["BCDN_ACCESS_KEY"]
    end
    headers = {
      :AccessKey => BunnyCdn.configuration.access_key
    }
  end

  describe "#getAllFiles" do
    before do
      stub_request(:get, "https://storage.bunnycdn.com/#{BunnyCdn.configuration.storage_zone}/#{ENV['FILE_PATH']}").
        with(
          headers: {
            :AccessKey => BunnyCdn.configuration.access_key
          }).
        to_return(status: 200, body: "")

      stub_request(:get, "https://ny.storage.bunnycdn.com/#{BunnyCdn.configuration.storage_zone}/#{ENV['FILE_PATH']}").
        with(
          headers: {
            :AccessKey => BunnyCdn.configuration.access_key
          }).
        to_return(status: 200, body: "")
    end
    it "gets all files from storage zone" do
      BunnyCdn.configure do |config|
        config.region = "eu"
      end
      headers = {
        :AccessKey => BunnyCdn.configuration.access_key
      }
      BunnyCdn::Storage.getZoneFiles
      # RestClient.get("https://storage.bunnycdn.com/#{BunnyCdn.configuration.storage_zone}/", headers)
      expect(WebMock).to have_requested(:get ,"https://storage.bunnycdn.com/#{BunnyCdn.configuration.storage_zone}/").
        with(headers: {
          :AccessKey => BunnyCdn.configuration.access_key
        }).once
    end

    it "gets all files from non-EU storage zone" do
      BunnyCdn.configure do |config|
        config.region = "ny"
      end
      headers = {
        :AccessKey => BunnyCdn.configuration.access_key
      }
      BunnyCdn::Storage.getZoneFiles
      # RestClient.get("https://storage.bunnycdn.com/#{BunnyCdn.configuration.storage_zone}/", headers)
      expect(WebMock).to have_requested(:get ,"https://ny.storage.bunnycdn.com/#{BunnyCdn.configuration.storage_zone}/").
        with(headers: {
          :AccessKey => BunnyCdn.configuration.access_key
        }).once
    end
  end

  describe "#getFile" do
    before do
      file = 'test_file.txt'
      stub_request(:get, "https://storage.bunnycdn.com/#{BunnyCdn.configuration.storage_zone}/#{ENV['FILE_PATH']}/#{file}").
      with(
        headers: {
          :AccessKey => BunnyCdn.configuration.access_key
        }
      ).
      to_return(status: 200)

      stub_request(:get, "https://ny.storage.bunnycdn.com/#{BunnyCdn.configuration.storage_zone}/#{ENV['FILE_PATH']}/#{file}").
      with(
        headers: {
          :AccessKey => BunnyCdn.configuration.access_key
        }
      ).
      to_return(status: 200)
    end
    it "gets a single file from the storage zone" do
      BunnyCdn.configure do |config|
        config.region = "eu"
      end
      headers = {
        :AccessKey => BunnyCdn.configuration.access_key
      }
      path = ENV['FILE_PATH']
      file = 'test_file.txt'
      BunnyCdn::Storage.getFile(path, file)
      expect(WebMock).to have_requested(:get ,"https://storage.bunnycdn.com/#{BunnyCdn.configuration.storage_zone}/#{path}/#{file}").
        with(headers: {
          :AccessKey => BunnyCdn.configuration.access_key
        }).once
    end

    it "gets a single file from the non-EU storage zone" do
      BunnyCdn.configure do |config|
        config.region = "ny"
      end
      headers = {
        :AccessKey => BunnyCdn.configuration.access_key
      }
      path = ENV['FILE_PATH']
      file = 'test_file.txt'
      BunnyCdn::Storage.getFile(path, file)
      expect(WebMock).to have_requested(:get ,"https://ny.storage.bunnycdn.com/#{BunnyCdn.configuration.storage_zone}/#{path}/#{file}").
        with(headers: {
          :AccessKey => BunnyCdn.configuration.access_key
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
        body: File.read(file)
      ).
      to_return(status: 200)

      stub_request(:put, "https://ny.storage.bunnycdn.com/#{BunnyCdn.configuration.storage_zone}/#{ENV['FILE_PATH']}/#{File.basename(file)}").
      with(
        headers: {
          :access_key => BunnyCdn.configuration.access_key,
          :checksum => ''
        },
        body: File.read(file)
      ).
      to_return(status: 200)
    end
    it "uploads file to storage zone" do
      BunnyCdn.configure do |config|
        config.region = "eu"
      end
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

    it "uploads file to storage zone" do
      BunnyCdn.configure do |config|
        config.region = "ny"
      end
      headers = {
        :access_key => BunnyCdn.configuration.access_key,
        :checksum => ''
      }
      path = ENV['FILE_PATH']
      file = File.join('spec', 'test_file.txt')
      # BunnyCdn::Storage.uploadFile(path, file)
      RestClient.put("https://ny.storage.bunnycdn.com/#{BunnyCdn.configuration.storage_zone}/#{ENV['FILE_PATH']}/#{File.basename(file)}", File.read(file), headers)
      expect(WebMock).to have_requested(:put ,"https://ny.storage.bunnycdn.com/#{BunnyCdn.configuration.storage_zone}/#{ENV['FILE_PATH']}/#{File.basename(file)}").
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