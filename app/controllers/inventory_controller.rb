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

    private

    def set_section
        @section = 'inventory'
    end
end
