# viewing file - for running the app

require "sinatra"
require "sinatra/reloader" if development?
require "pry-byebug"
require "better_errors"
require_relative "cookbook"
require "csv"
require_relative "recipe"
require_relative "scrape_lets_cook_french_service"

configure :development do
  use BetterErrors::Middleware
  BetterErrors.application_root = File.expand_path('..', __FILE__)
end
filepath = File.join(__dir__, "recipes.csv")
cookbook = Cookbook.new(filepath)

# Navigation

get '/' do
  erb :index
end

get '/list' do
  @cookbook = cookbook.all
  erb :list
end

get '/add' do
  erb :add
end

get '/import' do
  @recipie_names = []
  erb :import
end

get '/delete' do
  @cookbook = cookbook.all
  erb :delete
end


post '/recipes' do
  new_recipe = Recipe.new(params[:name], params[:description])
  new_recipe.prep_time = params[:prep]
  new_recipe.difficulty = params[:difficulty]
  cookbook.add_recipe(new_recipe)
  @cookbook = cookbook.all
  erb :list
  end

post '/remove' do
  index_to_delete = params[:index].to_i - 1
  cookbook.remove_recipe(index_to_delete)
  @cookbook = cookbook.all
  erb :list
end

post '/search' do
imported_page = ScrapeLetsCookFrenchService.new(params[:keyword])
@@recipe_names = imported_page.call
erb :import
end

post '/import' do
  chosen = params[:index].to_i - 1
    # add recipe to cookbook
  new_recipe = Recipe.new(@@recipe_names[chosen][:name], @@recipe_names[chosen][:description])
  new_recipe.prep_time = @@recipe_names[chosen][:prep]
  new_recipe.difficulty = @@recipe_names[chosen][:difficulty]
  cookbook.add_recipe(new_recipe)
  @cookbook = cookbook.all
  erb :list
end

get '/listed/:index' do
  puts params[:index] 
  @recipe = cookbook.all[params[:index].to_i - 1] 
  erb :listed
end