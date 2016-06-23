require "test_helper"

describe ::NIPAP::Client do
  it "will connect to an NIPAP server" do
    client = ::NIPAP::Client.new("http://nipap:nipap@localhost:1337")
  end
end
