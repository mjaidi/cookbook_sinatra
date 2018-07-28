# Main file - Model for the MVC framework
class Recipe
  attr_accessor :name, :description, :prep_time, :mark, :difficulty
  def initialize(name, description)
    @name = name
    @description = description
    @prep_time = ""
    @mark = "[ ]"
    @difficulty = ""
  end
end