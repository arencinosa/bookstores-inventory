class BooksController < ApplicationController
    before_action :set_section
    before_action :load_book, only: [:destroy]

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

    def destroy
        @book.destroy
        respond_to do |format|
            format.html { redirect_to books_path, notice: 'Book deleted successfully.' }
            format.json { render status: 204 }
        end
    end


    private

    def set_section
        @section = 'books'
    end

    def load_book
        @book = Book.find(params[:id])
    end

    def book_params
        ( params.has_key?(:book) ? params.require(:book) : params ).permit(:name)
    end
end
