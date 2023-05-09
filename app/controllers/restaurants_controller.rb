class RestaurantsController < ApplicationController
    def index
        restaurants = Restaurant.all 
        render json: restaurants, status: :ok
    end

    def show
        restaurants = Restaurant.find_by(id: params[:id])
        if restaurants
            render json: restaurants, include: :pizzas, status: :ok
        else 
            render json: { error: "Restaurant is unavailable" }, status: :not_found
        end
    end

    def destroy
        restaurants = Restaurant.find_by(id: params[:id])
        if restaurants
            restaurants.destroy 
            head :no_content
        else
            render json: { error: "Restaurant is unavailable" }, status: :not_found
        end
    end

end