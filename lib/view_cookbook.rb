# Viewing file that hass all the puts and other messages displayed to the user
class ViewCookbook
  def display(cookbook)
    cookbook.each_with_index do |recipe, index|
      puts "#{index + 1} - #{recipe.mark} Name: #{recipe.name}\n     Difficulty: #{recipe.difficulty} Time: #{recipe.prep_time}\n     Description: #{recipe.description}"
    end
  end

  def ask_user_for_recipie
    puts "Please enter the recipe name"
    recipe = gets.chomp
    puts "Please enter the recipe description"
    description = gets.chomp
    puts "Please enter time for recipe"
    time = gets.chomp
    puts "Please enter difficulty for recipe"
    difficulty = gets.chomp
    [recipe, description, time, difficulty]
  end

  def ask_user_to_delete
    puts "Please select the # of the recipe you want to remove"
    gets.chomp
  end

  def ask_user_for_keyword
    puts "What ingredient would you like a recipe for?"
    gets.chomp
  end

  def display_searching(keyword)
    puts ""
    puts "Looking for #{keyword} on LetsCookFrench ..."
    puts ""
  end

  def display_imported_list(imported_list)
    imported_list.each_with_index do |recipe, index|
      puts "#{index + 1} - #{recipe[:name]} (#{recipe[:prep]})"
    end
  end

  def choose_import
    puts "Which recipe would you like to import? (enter the index)"
    gets.chomp
  end

  def choose_mark(cookbook)
    puts "Choose index of recipe to mark"
    index_mark = gets.chomp
    index_mark = index_mark.to_i - 1
    cookbook[index_mark].mark = "[X]"
    
  end
end