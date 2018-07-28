# Controller - retrieve data from repository and prepare them for viewing
require_relative 'recipe'
require_relative 'view_cookbook.rb'
require_relative 'scrape_lets_cook_french_service'

class Controller
  def initialize(cookbook)
    # takes an instance of the cookbook as an argument
    @cookbook = cookbook
    @view = ViewCookbook.new
  end

  def list
    # requires tasks to be listed from viewer
    recipes = @cookbook.all
    @view.display(recipes)
  end

  def create
    # sends messages to other parts of the program to create recipie
    recipe = @view.ask_user_for_recipie
    # create new recipe
    new_recipe = Recipe.new(recipe[0], recipe[1])
    new_recipe.prep_time = recipe[2]
    new_recipe.difficulty = recipe[4]
    # add recipe to cookbook
    @cookbook.add_recipe(new_recipe)
  end

  def destroy
    # sends messages to other parts of the program to remove recipe
    list
    index_to_delete = @view.ask_user_to_delete.to_i - 1
    # remove recipe from cookbook
    @cookbook.remove_recipe(index_to_delete)
  end

  def import
    # display search keyword
    keyword = @view.ask_user_for_keyword
    @view.display_searching(keyword)
    # search web page
    imported_page = ScrapeLetsCookFrenchService.new(keyword)
    # save scraped info into an array
    recipe_names = imported_page.call
    @view.display_imported_list(recipe_names)
    # choose which recipie to add
    chosen = @view.choose_import.to_i - 1
    # add recipe to cookbook
    new_recipe = Recipe.new(recipe_names[chosen][:name], recipe_names[chosen][:description])
    new_recipe.prep_time = recipe_names[chosen][:prep]
    new_recipe.difficulty = recipe_names[chosen][:difficulty]
    @cookbook.add_recipe(new_recipe)
  end

  def mark
    list
    # choose recipe to mark
    recipes = @cookbook.all
    @view.choose_mark(recipes)
    # display recipes
    @cookbook.mark
    list
  end

end
