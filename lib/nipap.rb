require "nipap/version"
require "nipap/client"
require "nipap/vrf"

# Ruby Client for NIPAP
module NIPAP
  def self.connect(uri)
    Client.new(uri)
  end
end
