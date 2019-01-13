class Item < ApplicationRecord

    has_many :specific_carts
    has_many :carts, through: :specific_carts


    validates :title, presence: true
    validates :item_id, uniqueness: true
    validates :inventory_count, numericality: {greater_than_or_equal_to: 0, only_integer: true}
    validates :price, numericality: {greater_than_or_equal_to: 0}


    BASECHARS = [('0'..'9').to_a,('A'..'Z').to_a,('a'..'z').to_a].flatten

    def self.create(attributes)
        attributes = {item_id: generate_alias}.merge(attributes || {})
        return super(attributes)
    end

    def self.create!(attributes)
        attributes = {item_id: generate_alias}.merge(attributes || {})
        return super(attributes)
    end

    def self.generate_alias
      unique = false
      while unique == false
        randalias = (0...8).map {BASECHARS[rand(62)]}.join
        if !self.find_by({item_id: randalias})
          unique = true
        end
      end
      randalias
    end

    def as_json(options)
      options[:except].nil? ? options[:except] = ['id'] : options[:except] << 'id'
      super(options)
    end

    def self.check_available(item_id, quantity) 
        item = self.find_by!({item_id: item_id})

        return item.inventory_count >= quantity

    end

    def check_available(quantity) 

        item = self
        return item.inventory_count >= quantity

    end


    class ItemUnavailableException < StandardError
        attr_reader :items
        def initialize(items)
            @items = items
        end
    end

end

