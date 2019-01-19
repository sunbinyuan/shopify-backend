require 'securerandom'

class Cart < ApplicationRecord
    has_many :specific_carts, dependent: :destroy
    has_many :items, through: :specific_carts

    validates :cart_id, uniqueness: true

    def compute_total()
        cart = self

        cart_items = cart.specific_carts
        sum = BigDecimal.new("0")

        cart_items.each do |item|
            sum += item.item.price * item.quantity
        end

        return sum

    end

    def self.purchase(cart_id)

        cart = self.find_by!({cart_id: cart_id})
        return cart.purchase()

    end

    def purchase()
        cart = self

        cart_items = cart.specific_carts

        unavailable = cart_items.select do |item|
            !item.item.check_available(item.quantity)
        end

        if !unavailable.empty?
            raise Item::ItemUnavailableException.new(unavailable)
        end

        cart_items.each do |item|

            # some payment logic here
            # maybe transfering cart items to an order model
            original_item = item.item
            original_item.inventory_count -= item.quantity
            original_item.save

        end

        cart.destroy()

    end

    def add_to_cart(item)
        raise ActiveRecord::RecordNotFound.new(nil, Item) if item.nil?

        cart = self
        cart_item = self.specific_carts.find_by({item: item})

        if cart_item.nil?
            if item.check_available(1)
                SpecificCart.create({item: item, cart: cart, quantity: 1})
            else
                raise Item::ItemUnavailableException.new(item)
            end
        else
            if item.check_available(cart_item.quantity + 1)
                cart_item.update({quantity: cart_item.quantity + 1})
            else
                raise Item::ItemUnavailableException.new([item])
            end
        end
        return cart
    end

    def self.add_to_cart(cart_id, item_id)

        cart = Cart.find_by!({cart_id: cart_id})
        
        item = Item.find_by!({item_id: item_id})

        return cart.add_to_cart(item)

    end

    def update_cart_item_quantity(item, quantity) 
        raise ActiveRecord::RecordNotFound.new(nil, Item) if item.nil?

        cart = self
        cart_item = self.specific_carts.find_by!({item: item})

        if (quantity == 0)
            cart_item.destroy()
        else
            if item.check_available(quantity)
                cart_item.update({quantity: quantity})
            else
                raise Item::ItemUnavailableException.new([item])
            end
        end
        return cart
    end

    def self.update_cart_item_quantity(cart_id, item_id, quantity)

        cart = Cart.find_by!({cart_id: cart_id})

        item = Item.find_by!({item_id: item_id})

        return cart.update_cart_item_quantity(item, quantity)

    end

    def self.create(attributes = nil)
        attributes = {cart_id: generate_alias}.merge(attributes || {})
        return super(attributes)
    end

    def self.create!(attributes = nil)
        attributes = {cart_id: generate_alias}.merge(attributes || {})
        return super(attributes)
    end

    def self.generate_alias
        return SecureRandom.hex()
    end
end


