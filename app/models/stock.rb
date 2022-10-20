class Stock < ApplicationRecord
    validates :stock_level, :numericality => { greater_or_equal_to: 0 }

    belongs_to :book
    belongs_to :bookstore

    after_initialize :init

    def init
        self.stock_level ||= 0 if self.has_attribute? :stock_level
    end
end
