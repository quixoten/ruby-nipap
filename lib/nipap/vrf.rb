module NIPAP
  class VRF

    def self.list(spec = {})
      req("list_vrf", { vrf: spec }).map do |vrf|
        self.new(vrf)
      end
    end

    def self.get(id)
      self.list(id: id).first
    end

    def self.save(vrf)
      attr = vrf.to_attr
      spec = { id: vrf.id }

      if vrf.id.nil?
        reply = req("add_vrf", { attr: attr })
      else
        reply = req("edit_vrf", { vrf: spec, attr: attr })[0]
      end

      self.new(reply)
    end

    def remove(vrf)
      req("remove_vrf", { vrf: { id: vrf.id } })
      true
    end

    def self.req(*args)
      NIPAP.client.req(*args)
    end

    attr_accessor :id
    attr_accessor :rt
    attr_accessor :name
    attr_accessor :description
    attr_accessor :avps
    attr_accessor :tags
    attr_accessor :num_prefixes_v4
    attr_accessor :num_prefixes_v6
    attr_accessor :total_addresses_v4
    attr_accessor :total_addresses_v6
    attr_accessor :used_addresses_v4
    attr_accessor :used_addresses_v6
    attr_accessor :free_addresses_v4
    attr_accessor :free_addresses_v6

    def initialize(params = {})
      self.id          = params.fetch(:id, nil)
      self.rt          = params.fetch(:rt, nil)
      self.name        = params.fetch(:name, nil)
      self.description = params.fetch(:description, nil)
      self.avps        = params.fetch(:avps, {})
      self.tags        = params.fetch(:tags, [])

      # vrf.tags = {}
      # for tag_name in parm['tags']:
      #   tag = Tag.from_dict({'name': tag_name })
      #   vrf.tags[tag_name] = tag

      self.num_prefixes_v4    = params.fetch(:num_prefixes_v4, 0)
      self.num_prefixes_v6    = params.fetch(:num_prefixes_v6, 0)
      self.total_addresses_v4 = params.fetch(:total_addresses_v4, 0)
      self.total_addresses_v6 = params.fetch(:total_addresses_v6, 0)
      self.used_addresses_v4  = params.fetch(:used_addresses_v4, 0)
      self.used_addresses_v6  = params.fetch(:used_addresses_v6, 0)
      self.free_addresses_v4  = params.fetch(:free_addresses_v4, 0)
      self.free_addresses_v6  = params.fetch(:free_addresses_v6, 0)
    end

    def num_prefixes_v4=(value)
      @num_prefixes_v4 = value.to_i
    end

    def num_prefixes_v6=(value)
      @num_prefixes_v6 = value.to_i
    end

    def total_addresses_v4=(value)
      @total_addresses_v4 = value.to_i
    end

    def total_addresses_v6=(value)
      @total_addresses_v6 = value.to_i
    end

    def used_addresses_v4=(value)
      @used_addresses_v4 = value.to_i
    end

    def used_addresses_v6=(value)
      @used_addresses_v6 = value.to_i
    end

    def free_addresses_v4=(value)
      @free_addresses_v4 = value.to_i
    end

    def free_addresses_v6=(value)
      @free_addresses_v6 = value.to_i
    end

    def to_attr
      {
        rt:           rt,
        name:         name,
        description:  description,
        avps:         avps,
        tags:         tags,
      }
    end
  end
end
