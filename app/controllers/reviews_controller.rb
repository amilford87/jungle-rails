class ReviewsController < ApplicationController
    def create
        @product = Product.find(params[:product_id])
        @review = @product.reviews.new(review_params)
        @review.user = current_user
        
        if @review.save
            redirect_to @product
        else 
            @error = "Please enter a review"
            render "products/show"
        end
      end

      def destroy
        @review = Review.find(params[:id])
        @product = Product.find(params[:product_id])
        if @review.user == current_user
        @review.destroy
        redirect_to @product
        end
      end

      private 

      def review_params
        params.require(:review).permit(:rating, :description)
    end
end
