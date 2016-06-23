require "nipap/version"
require "nipap/client"
require "nipap/vrf"

module NIPAP
  def self.connect_to(uri)
    self.client = Client.new(uri)
  end

  def self.client=(client)
    @client = client
  end

  def self.client
    @client
  end
end
