require "spec_helper"

RSpec.describe BunnyCdn::Configuration do
    it "has configuration class" do
    end

    describe "#configure" do
        it "has default values of nil" do
            config = BunnyCdn::Configuration.new
            expect(config.storage_zone).to eq(nil)
            expect(config.access_key).to eq(nil)
        end
    end

    describe "#configure=" do
        it "is able to accept values" do
            config = BunnyCdn::Configuration.new
            config.storage_zone = 'test'
            config.access_key = 'test'
            expect(config.storage_zone).to eq('test')
            expect(config.access_key).to eq('test')
        end
    end

    describe "#configuration" do
        before do
            BunnyCdn.configure do |config|
                config.storage_zone = 'test'
                config.access_key = 'test'
            end
        end
        it "can read configuration values" do
            expect(BunnyCdn.configuration.storage_zone).to eq('test')
            expect(BunnyCdn.configuration.access_key).to eq('test')
        end
    end

end