class Meal
    def initialize(attributes = {})
        @id    = attributes[:id]
        @name  = attributes[:name]
        @price = attributes[:price]
    end

    attr_accessor :id
    attr_reader   :name, :price
end
