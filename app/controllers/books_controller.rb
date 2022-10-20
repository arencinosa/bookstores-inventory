class BooksController < ApplicationController

    def index
        @books = Book.all
        respond_to do |format|
            format.html
            format.json { render json: @books }
        end
    end

    def create
        @book = Book.new(book_params)

        if @book.save
            respond_to do |format|
                format.html { redirect_to books_path, notice: 'Book created successfully.' }
                format.json { render json: @book }
            end
        else
            respond_to do |format|
                format.any { render json: { response: @book.errors.full_messages}, status: 400 }
            end
        end
    end


    private

    def book_params
        ( params.has_key?(:book) ? params.require(:book) : params ).permit(:name)
    end
end
