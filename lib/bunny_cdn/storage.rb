module BunnyCdn
  class Storage
    
    RestClient.log = STDOUT # enables RestClient logging

    BASE_URL = 'https://storage.bunnycdn.com'

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
        response = RestClient.get("#{BASE_URL}/#{storage_zone}/#{path}", headers)
      rescue RestClient::ExceptionWithResponse => exception
        return exception
      end
      return response.body
    end

    def self.getFile(path= '', file)
      begin
        response = RestClient.get("#{BASE_URL}/#{storage_zone}/#{path}/#{file}", headers)
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
        response = RestClient.put("#{BASE_URL}/#{storage_zone}/#{path}/#{fileName}", File.read(file), headers)
      rescue RestClient::ExceptionWithResponse => exception
        return exception
      end
      return response.body
    end

    def self.deleteFile(path= '', file)
      begin
        response = RestClient.delete("#{BASE_URL}/#{storage_zone}/#{path}/#{file}", headers)
      rescue RestClient::ExceptionWithResponse => exception
        return exception
      end
      return response.body
    end

  end
end