class InventoryController < ApplicationController
    before_action :set_section

    def index
        @books_amount = Book.count
        @bookstores_amount = Bookstore.count
        @total_stock = Stock.sum(:stock_level)

        respond_to do |format|
            format.html
            format.json { render json: { books: @books_amount, bookstores: @bookstores_amount, stock: @total_stock } }
        end
    end

    def get_stock_level
        stock = Stock.find_by(book_id: params[:book_id], bookstore_id: params[:bookstore_id])
        stock_level = stock.nil? ? 0 : stock.stock_level
        respond_to do |format|
            format.any { render json: stock_level }
        end
    end

    def set_stock_level
        @stock = Stock.find_or_create_by(book_id: params[:book_id], bookstore_id: params[:bookstore_id])
        @stock.stock_level = params[:stock_level]

        if @stock.save
            respond_to do |format|
                format.any { head 204 }
            end
        else
            respond_to do |format|
                format.any { render json: { response: @stock.errors.full_messages}, status: 400 }
            end
        end
    end

    private

    def set_section
        @section = 'inventory'
    end
end
