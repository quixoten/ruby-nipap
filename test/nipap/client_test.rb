require "test_helper"

describe ::NIPAP::Client do
  it "will connect to an NIPAP server" do
    client = ::NIPAP::Client.new("http://nipap:nipap@localhost:1337")
  end

  it "will list vrfs" do
    client = ::NIPAP::Client.new("http://nipap:nipap@localhost:1337")
    vrfs = client.list_vrfs

    assert_equal 1, vrfs.size
    assert_instance_of ::NIPAP::VRF, vrfs.first
    assert_equal "default", vrfs.first.name
  end

  it "will get a vrf by id" do
    client = ::NIPAP::Client.new("http://nipap:nipap@localhost:1337")
    vrf    = client.get_vrf(0)

    assert_instance_of ::NIPAP::VRF, vrf
    assert_equal "default", vrf.name
    assert_equal 0, vrf.id
  end

  it "will update a vrf" do
    client   = ::NIPAP::Client.new("http://nipap:nipap@localhost:1337")
    vrf      = client.get_vrf(0)
    vrf.name = "new default"

    client.save_vrf(vrf)
    assert_equal "new default", client.get_vrf(0).name

    vrf.name = "default"
    client.save_vrf(vrf)
  end

  it "will create and remove a vrf" do
    client  = ::NIPAP::Client.new("http://nipap:nipap@localhost:1337")
    vrf     = ::NIPAP::VRF.new(name: "new2", rt: "123:458")
    vrf     = client.save_vrf(vrf)

    refute_nil vrf.id
    client.remove_vrf(vrf)
    assert_nil client.get_vrf(vrf.id)
  end
end
