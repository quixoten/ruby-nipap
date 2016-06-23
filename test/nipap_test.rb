require "test_helper"

describe ::NIPAP do
  it "will specify a version" do
    refute_nil ::NIPAP::VERSION
  end
end
