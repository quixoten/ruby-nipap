require "xmlrpc/client"

::XMLRPC::Config.module_eval { remove_const(:ENABLE_NIL_PARSER) }
::XMLRPC::Config.const_set(:ENABLE_NIL_PARSER, true)

::XMLRPC::Config.module_eval { remove_const(:ENABLE_NIL_CREATE) }
::XMLRPC::Config.const_set(:ENABLE_NIL_CREATE, true)

module NIPAP
  class Client
    attr_reader :uri

    AUTH = {  authoritative_source: "ruby-nipap" }.freeze

    def initialize(uri)
      @uri  = uri
      @conn = ::XMLRPC::Client.new2(self.uri)
    end

    def list_vrfs(spec = {})
      @conn.call("list_vrf", { vrf: spec, auth: AUTH }).map do |vrf|
        VRF.new(symbolize_keys(vrf))
      end
    end

    def get_vrf(id)
      list_vrfs(id: id).first
    end

    def save_vrf(vrf)
      attr = vrf.to_attr
      spec = { id: vrf.id }

      if vrf.id.nil?
        resp = @conn.call("add_vrf", { attr: attr, auth: AUTH })
      else
        resp = @conn.call("edit_vrf", { vrf: spec, attr: attr, auth: AUTH })[0]
      end

      VRF.new(symbolize_keys(resp))
    end

    def remove_vrf(vrf)
      @conn.call("remove_vrf", { vrf: { id: vrf.id }, auth: AUTH })
      true
    end

    def symbolize_keys(hash)
      hash.keys.inject({}) do |symbolized_hash, key|
        symbolized_hash[key.to_sym] = hash[key]
        symbolized_hash
      end
    end
  end
end
