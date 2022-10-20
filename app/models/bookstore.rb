class Bookstore < ApplicationRecord
    validates :name, :presence => true

    has_many :stocks, :dependent => :destroy
    has_many :books, :through => :stocks
end
