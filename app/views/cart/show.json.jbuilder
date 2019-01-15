json.cart_id @cart.cart_id
json.total @cart.compute_total()
json.specific_cart @cart.specific_carts do |specific_cart|
	json.quantity specific_cart.quantity
	json.item do |item|
		item.title specific_cart.item.title
		item.price specific_cart.item.price
		item.inventory_count specific_cart.item.inventory_count
		item.description specific_cart.item.description
		item.item_id specific_cart.item.item_id
	end
end

