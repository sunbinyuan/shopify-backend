class Cart < ApplicationRecord
    has_many :specific_carts
    has_many :items, through: :specific_carts

    validates :cart_id, uniqueness: true

    BASECHARS = [('0'..'9').to_a,('a'..'f').to_a].flatten

    def self.computeTotal(cartId)
        cart = Cart.find({cart_id: cartId})
        if cart.nil?
            raise ActiveRecord::RecordNotFound
        end

        cart_items = cart.specific_carts
        sum = BigDecimal.new("0")

        cart_items.each do |item|
            sum += item.item.price * item.quantity
        end

        return sum

    end

    def self.purchase(cartId)
        cart = Cart.find({cart_id: cartId})
        if cart.nil?
            raise ActiveRecord::RecordNotFound
        end

        cart_items = cart.specific_carts

        unavailable = cart_items.select do |item|
            item.quantity > item.item.inventory_count
        end

        if !unavailable.empty?
            raise ItemUnavailableException.new(unavailable)
        end

        cart_items.each do |item|

            # some payment logic here
            # maybe transfering cart items to an order
            original_item = item.item
            original_item.inventory_count -= item.quantity
            original_item.save

        end

        cart.destroy

    end

    def self.add_to_cart(cartId, itemId)
        cart = Cart.find({cart_id: cartId})
        if cart.nil?
            raise ActiveRecord::RecordNotFound
        end
    end

    def self.create(attributes = nil)
        attributes = {cart_id: self.generate_alias}.merge(attributes || {})
        return self.new(attributes).save
    end

    def self.generate_alias
      unique = false
      while unique == false
        randalias = (0...32).map {BASECHARS[rand(16)]}.join
        if !self.find_by({cart_id: randalias})
          unique = true
        end
      end
      randalias
    end
end
