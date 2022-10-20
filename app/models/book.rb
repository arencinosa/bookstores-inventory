class Book < ApplicationRecord
    validates :name, :presence => true

    has_many :stocks, :dependent => :destroy
    has_many :bookstores, :through => :stocks
end
