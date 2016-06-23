require "xmlrpc/client"

::XMLRPC::Config.module_eval { remove_const(:ENABLE_NIL_PARSER) }
::XMLRPC::Config.const_set(:ENABLE_NIL_PARSER, true)

::XMLRPC::Config.module_eval { remove_const(:ENABLE_NIL_CREATE) }
::XMLRPC::Config.const_set(:ENABLE_NIL_CREATE, true)

module NIPAP
  class Client
    attr_reader :uri

    AUTH = {  auth: { authoritative_source: "ruby-nipap" }.freeze }.freeze

    def initialize(uri)
      @uri = uri
      @rpc = ::XMLRPC::Client.new2(self.uri)
    end

    def req(method, params = {})
      reply = @rpc.call(method, params.merge(AUTH))
      symbolize_keys(reply)
    end

    def symbolize_keys(obj)
      case obj
      when Hash
        obj.keys.inject({}) do |symbolized_hash, key|
          symbolized_hash[key.to_sym] = symbolize_keys(obj[key])
          symbolized_hash
        end
      when Array
        obj.map do |value|
          symbolize_keys(value)
        end
      else
        obj
      end
    end
  end
end
