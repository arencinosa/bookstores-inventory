class InventoryController < ApplicationController
    before_action :set_section

    def index
        @books_amount = Book.count
        @bookstores_amount = Bookstore.count
        @total_stock = Stock.sum(:stock_level)
        @summary = get_summary_by_bookstore

        respond_to do |format|
            format.html
            format.json { render json: { books: @books_amount, bookstores: @bookstores_amount, stock: @total_stock, summary: @summary } }
        end
    end

    def by_bookstores
        @summary = get_summary_by_bookstore

        respond_to do |format|
            format.any { render json: @summary }
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
                format.html { redirect_to inventory_path, notice: 'Stock level updated successfully.' }
                format.json { head 204 }
            end
        else
            respond_to do |format|
                format.any { render json: { response: @stock.errors.full_messages}, status: 400 }
            end
        end
    end

    private

    def get_summary_by_bookstore
        summary = []
        Bookstore.all.each do |bookstore|
            entry = {
                bookstore_id: bookstore.id,
                bookstore_name: bookstore.name,
                books: {
                    in_stock: [],
                    out_of_stock: []
                }
            }
            Book.all.each do |book|
                stock = Stock.find_by(book_id: book.id, bookstore_id: bookstore)
                if stock.nil? || stock.stock_level == 0
                    entry[:books][:out_of_stock] << {
                        book_id: book.id,
                        book_name: book.name
                    }
                else
                    entry[:books][:in_stock] << {
                        book_id: book.id,
                        book_name: book.name,
                        stock_level: stock.stock_level
                    }
                end
            end
            summary << entry
        end

        return summary
    end

    def set_section
        @section = 'inventory'
    end
end
