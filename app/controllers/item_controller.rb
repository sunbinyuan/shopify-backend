class ItemController < ApplicationController

    def index(show_all = false)
        items = nil
        if show_all
            items = Item.all.select(:title, :price, :inventory_count, :description, :id)
        else
            items = Item.where("inventory_count > 0").select(:title, :price, :inventory_count, :description, :id)
        end

        render json: items
    end

    def show()
    end

    def destroy
        pars =params.require(:id)
        id = pars[:id]
        begin
            item = Item.find(id)
            item.destroy
        rescue ActiveRecord::RecordNotFound
            render json: "Item not found."
        rescue ActiveRecord::RecordNotDestroyed
            render json: "An error happened when removing the item."
        end
            render json: "Item removed."
    end

    def create
        pars = params.require([:title, :price, :inventory_count]).permits(:description)
        item = Item.create(pars)
        begin
            item = Item.create(pars)
            item.save
        rescue ActiveRecord::RecordNotSaved
            render json: "An error happened when adding the item."
        end
    end


end
