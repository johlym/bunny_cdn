module BunnyCdn
    class Configuration
        attr_accessor :storage_zone, :access_key, :api_key

        def initialize
            @storage_zone = nil
            @access_key = nil
            @api_key = nil
        end
    end

    def self.configuration
        @configuration ||= Configuration.new
    end

    # Set BunnyCdn's configuration
    def self.configuration=(config)
        @configuration = config
    end

    def self.configure
        yield(configuration)
    end
end