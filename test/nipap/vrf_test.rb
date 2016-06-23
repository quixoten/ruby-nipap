require "test_helper"

describe ::NIPAP::VRF do
  before do
    ::NIPAP.connect_to("http://nipap:nipap@localhost:1337")
  end

  it "will list all vrfs" do
    vrfs = ::NIPAP::VRF.list

    assert_instance_of ::Array, vrfs
    assert_instance_of ::NIPAP::VRF, vrfs.first
    assert_equal "default", vrfs.first.name
  end

  it "will list specific vrfs" do

  end

  it "will get a vrf by id" do
    vrf = ::NIPAP::VRF.get(0)

    assert_instance_of ::NIPAP::VRF, vrf
    assert_equal "default", vrf.name
    assert_equal 0, vrf.id
  end

  it "will update a vrf" do
    vrf      = ::NIPAP::VRF.get(0)
    vrf.name = "new default"

    assert_equal "new default", ::NIPAP::VRF.get(0).name

    vrf.name = "default"
    ::NIPAP::VRF.save(vrf)
  end

  it "will create and remove a vrf" do
    vrf = ::NIPAP::VRF.new(name: "new2", rt: "123:458")
    vrf = ::NIPAP::VRF.save(vrf)

    refute_nil vrf.id
    ::NIPAP::VRF.remove(vrf)
    assert_nil client.get_vrf(vrf.id)
  end

end
