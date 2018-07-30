# Repository - replaces database and stores recipes in csv file
require_relative 'recipe'
require 'csv'
class Cookbook
  def initialize(csv_file_path)
    # loads existing recipes from CSV file
    @cookbook = []
    @file_path = csv_file_path
    open
  end

  def all
    # returns all recipes
    @cookbook
  end

  def add_recipe(recipe)
    # adds new recipe to the cookbook
    @cookbook << recipe
    store
  end

  def remove_recipe(recipe_index)
    # removes recipe from the cookbook (through index)
    @cookbook.delete_at(recipe_index)
    store
  end

  def mark
    store
  end
  
  private

  def open
    CSV.read(@file_path)
    @csv_options = { headers: ["Recipe", "Description", "Prep", "Mark", "Difficulty"] }
    CSV.foreach(@file_path, @csv_options) do |row|
      new_recipe = Recipe.new(row["Recipe"], row["Description"])
      new_recipe.prep_time = row["Prep"]
      new_recipe.mark = row["Mark"]
      new_recipe.difficulty = row["Difficulty"]
      @cookbook << new_recipe
    end
  end

  def store
    CSV.open(@file_path, 'wb', @csv_options) do |csv|
      @cookbook.each do |recipe|
        csv << [recipe.name, recipe.description, recipe.prep_time, recipe.mark, recipe.difficulty]
      end
    end
  end
end