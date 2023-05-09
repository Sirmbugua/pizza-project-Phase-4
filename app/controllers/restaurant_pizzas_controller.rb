class RestaurantPizzasController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response

    def create
        restaurant_pizza = RestaurantPizza.create!(params.permit(:restaurant_id, :pizza_id, :price))
        if restaurant_pizza.valid?
            render json: restaurant_pizza.pizza, status: :created 
        else
            render json: { errors: restaurant_pizza.errors }, status: :unprocessable_entity
        end
          
    end

    private

    def render_not_found_response
        render json: { error: "The restaurant is not found" }, status: :not_found
    end

    def render_unprocessable_entity_response(invalid)
        render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
    end
end