require "./test/test_helper"

describe "configuration" do

  before do
    Taxjar.reset
  end

  Taxjar::Configuration::VALID_CONFIG_KEYS.each do |key|
    describe ".#{key}" do
      it "should return the default value" do
        Taxjar.send(key).must_equal Taxjar::Configuration.const_get("DEFAULT_#{key.upcase}")
      end
    end
  end

  describe ".configure" do
    Taxjar::Configuration::VALID_CONFIG_KEYS.each do |key|
      it "should set the #{key}" do
        Taxjar.configure do |config|
          config.send("#{key}=", key)
          Taxjar.send(key).must_equal key
        end
      end
    end
  end
end
