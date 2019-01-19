Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  scope :api do

    post 'login', to: "login#login"
    post 'logout', to: "login#logout"

  	scope :item do
  		get 'all', to: "item#index"
  		get ':item_id', to: "item#show"
  		post '', to: "item#create"
  		put ':item_id', to: "item#update"
  		delete ':item_id', to: "item#destroy"
  	end

  	scope :cart do
      get '', to: "cart#show" 
      post 'new', to: "cart#create"
      post '', to: "cart#add_to_cart"
      put '', to: "cart#update_cart_item_quantity"
      delete '', to: "cart#remove_cart_item"
      post 'purchase', to: "cart#purchase"
  		
  	end
  end
end
