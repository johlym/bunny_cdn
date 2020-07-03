module BunnyCdn
  class Storage
    
    RestClient.log = STDOUT # enables RestClient logging

    BASE_URL = 'https://storage.bunnycdn.com'

    def self.base_url
      if BunnyCdn.configuration.region
        "https://#{BunnyCdn.configuration.region}.storage.bunnycdn.com"
      else
        "https://storage.bunnycdn.com"
      end
    end

    def self.storage_zone
      BunnyCdn.configuration.storage_zone
    end

    def self.api_key
      BunnyCdn.configuration.access_key
    end

    def self.headers
      {
        :access_key => api_key
      }
    end

    def self.getZoneFiles(path= '')
      begin
        response = RestClient.get("#{base_url}/#{storage_zone}/#{path}", headers)
      rescue RestClient::ExceptionWithResponse => exception
        return exception
      end
      return response.body
    end

    def self.getFile(path= '', file)
      begin
        response = RestClient.get("#{base_url}/#{storage_zone}/#{path}/#{file}", headers)
      rescue RestClient::ExceptionWithResponse => exception
        return exception
      end
      return response.body
    end

    def self.uploadFile(path= '', file)
      fileName = File.basename(file)
      headers = {
        :access_key => api_key,
        :checksum => ''
      }
      begin
        response = RestClient.put("#{base_url}/#{storage_zone}/#{path}/#{fileName}", File.read(file), headers)
      rescue RestClient::ExceptionWithResponse => exception
        return exception
      end
      return response.body
    end

    def self.deleteFile(path= '', file)
      begin
        response = RestClient.delete("#{base_url}/#{storage_zone}/#{path}/#{file}", headers)
      rescue RestClient::ExceptionWithResponse => exception
        return exception
      end
      return response.body
    end

  end
end