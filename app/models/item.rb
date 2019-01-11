class Item < ApplicationRecord

    has_many :specific_carts
    has_many :carts, through: :specific_carts

    # alias_attribute :id, :alias

    validates :alias, uniqueness: true
    validates :inventory_count, numericality: {greater_than_or_equal_to: 0}
    BASECHARS = [('0'..'9').to_a,('A'..'Z').to_a,('a'..'z').to_a].flatten

    def self.create(*args)
        args[0][:alias] = self.generate_alias
        return self.new(*args)
    end

    def self.updateInventoryCount(*args)
        id = args[:alias]
        count = args[:inventory_count]

        item = self.find_by({alias: id})
        if item.nil?
            raise ActiveRecord::RecordNotFound
        end

        if item.update({inventory_count: inventory_count})
            return true
        else
            raise ActiveRecord::RecordNotSaved
        end
    end

    def self.generate_alias
      unique = false
      while unique == false
        randalias = (0...8).map {BASECHARS[rand(62)]}.join
        if !self.find_by({alias: randalias})
          unique = true
        end
      end
      randalias
    end

    def as_json(options)
        self.attribute_aliases =  {"id"=>"alias"}.merge(attribute_aliases)
      options[:except].nil? ? options[:except] = ['alias'] : options[:except] << ['alias']
      super(options)
    end

end

class ItemUnavailableException < StandardError
    attr_reader :items
    def initialize(items)
        @items = items
    end
end