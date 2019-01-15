class CartController < ApplicationController
	skip_before_action :verify_authenticity_token

	rescue_from Item::ItemUnavailableException, with: :handle_item_unavailable

	def create()
		@cart = Cart.create!()

		render 'cart/show'	
	end

	def show()
		cart_id = params[:cart_id]
		@cart = Cart.find_by!({cart_id: cart_id})

		render 'cart/show'
		# render json: cart.to_json(
		# 	methods: [:compute_total],
		# 	include: {
		# 		specific_carts: {
		# 			include: {
		# 				item: {
		# 					only: [:title, :price, :inventory_count, :description, :item_id]
		# 				}
		# 			},
		# 			only: [:quantity]
		# 		}
		# 	},
		# 	only: [:cart_id])
	end

	def add_to_cart()

		cart_id = params[:cart_id]
		item_id = params[:item_id]

		@cart = Cart.add_to_cart(cart_id, item_id)

		render 'cart/show'

	end


	def update_cart_item_quantity()

		cart_id = params[:cart_id]
		item_id = params[:item_id]
		quantity = params[:quantity]
		if (quantity.nil? || quantity == 0)
			render json: {error: "Quantity cannot be empty"}
			return
		end

		@cart = Cart.update_cart_item_quantity(cart_id, item_id, quantity)

		render 'cart/show'

	end

	def remove_cart_item
		cart_id = params[:cart_id]
		item_id = params[:item_id]
		@cart = Cart.update_cart_item_quantity(cart_id, item_id, 0)
		render 'cart/show'
	end

	def purchase
		cart_id = params[:cart_id]
		Cart.purchase(cart_id)

		render json: {}
	end

	private

	def handle_item_unavailable(error)
		items = error.data

		items = items.collect do |item|
			c = item.attributes
			c.slice('title', 'price', 'inventory_count', 'description', 'item_id')
		end

		render json: {error: "The requested quantity is not available for the current Item", data: items, status: 400}
	end
end
