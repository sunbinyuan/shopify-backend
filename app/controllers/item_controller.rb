class ItemController < ApplicationController
    skip_before_action :verify_authenticity_token

    def index()

        show_all = params[:show_all] || false
        items = nil
        if show_all
            items = Item.all.select(:title, :price, :inventory_count, :description, :item_id)
        else
            items = Item.where("inventory_count > 0").select(:title, :price, :inventory_count, :description, :item_id)
        end

        render json: items
    end

    def show()
        item_id = params[:item_id]
        item = Item.select(:title, :price, :inventory_count, :description, :item_id).find_by!({item_id: item_id})
        render json: item
    end

    def update()
        item_id = params[:item_id]

        item = Item.find_by!({item_id: item_id})
        pars = params.permit(:title, :price, :inventory_count, :description)
        item.update!(pars)

        item = Item.select(:title, :price, :inventory_count, :description, :item_id).find(item.id)
        render json: item
    end

    def destroy()
        item_id = params[:item_id]

        item = Item.find_by!({item_id: item_id})
        item.destroy()
        render json: {}
    end

    def create
        pars = params.require(:item).permit(:title, :price, :inventory_count, :description)

        item = Item.create!(pars)

        item = Item.select(:title, :price, :inventory_count, :description, :item_id).find(item.id)
        render json: item

    end

end
