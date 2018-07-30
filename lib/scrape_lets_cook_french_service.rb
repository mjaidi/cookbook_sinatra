require 'open-uri'
require 'nokogiri'

class ScrapeLetsCookFrenchService
  def initialize(keyword)
    @keyword = keyword
    html_content = open("http://www.letscookfrench.com/recipes/find-recipe.aspx?aqt=#{keyword}").read
    # file = File.open("../html_files/strawberry.html")
    @doc = Nokogiri::HTML(html_content, nil, 'utf-8')
    @recipes = []
  end

  def call
    # TODO: return a list of `Recipes` built from scraping the web.
    @doc.search('.m_titre_resultat a').each_with_index do |element, index|
      @recipes[index] = {}
      @recipes[index][:name] = element.text.strip
    end
    @doc.search('.m_texte_resultat').each_with_index do |element, index|
      @recipes[index][:description] = element.text.strip
    end
    @doc.search('.m_detail_time').each_with_index do |element, index|
      @recipes[index][:prep] = element.text.strip.split("   ")[1].strip
    end
    @doc.search('.m_detail_recette').each_with_index do |element, index|
      @recipes[index][:difficulty] = element.text.strip.split("-")[2].strip
    end
    @recipes[0..4]
end
end
