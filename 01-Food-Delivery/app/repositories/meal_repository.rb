require "csv"
require_relative "../models/meal"

class MealRepository
    def initialize(csv_file)
        @csv_file = csv_file
        @meals    = []
        @next_id  = 1

        load_csv() if File.exist?(@csv_file)
    end

    def all
        @meals
    end

    def find(id)
        @meals.find do |meal|
            meal.id == id
        end
    end

    def create(new_meal)
        new_meal.id = @next_id
        @meals << new_meal
        @next_id += 1

        save_csv()
    end

    private

    def save_csv
        CSV.open(@csv_file, "wb") do |csv|
            csv << ["id", "name", "price"]

            @meals.each do |meal|
                csv << [meal.id, meal.name, meal.price]
            end
        end
    end

    def load_csv
        CSV.foreach(@csv_file, headers: :first_row, header_converters: :symbol) do |row|
            id    = row[:id].to_i
            name  = row[:name]
            price = row[:price].to_i

            meal = Meal.new(id: id, name: name, price: price)
            @meals << meal
        end
        @next_id = @meals.last.id + 1 unless @meals.empty?
    end
end
