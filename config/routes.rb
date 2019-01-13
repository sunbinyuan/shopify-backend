Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  scope :api do

  	scope :item do
  		get 'all', to: "item#index"
  		get ':item_id', to: "item#show"
  		post '', to: "item#create"
  		put ':item_id', to: "item#update"
  		delete ':item_id', to: "item#destroy"
  	end

  	scope :cart do
  		
  	end
  end
end
