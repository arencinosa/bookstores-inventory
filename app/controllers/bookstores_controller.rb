class BookstoresController < ApplicationController
    before_action :set_section

    def index
        @bookstores = Bookstore.all
        respond_to do |format|
            format.html
            format.json { render json: @bookstores }
        end
    end

    def create
        @bookstore = Bookstore.new(bookstore_params)

        if @bookstore.save
            respond_to do |format|
                format.html { redirect_to bookstores_path, notice: 'Bookstore created successfully.' }
                format.json { render json: @bookstore }
            end
        else
            respond_to do |format|
                format.any { render json: { response: @bookstore.errors.full_messages}, status: 400 }
            end
        end
    end

    def destroy
        @bookstore.destroy
        respond_to do |format|
            format.html { redirect_to bookstores_path, notice: 'Bookstore deleted successfully.' }
            format.json { render status: 204 }
        end
    end


    private

    def set_section
        @section = 'bookstores'
    end

    def load_bookstore
        @bookstore = Bookstore.find(params[:id])
    end

    def bookstore_params
        ( params.has_key?(:bookstore) ? params.require(:bookstore) : params ).permit(:name)
    end
end
