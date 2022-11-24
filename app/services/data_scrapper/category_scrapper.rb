module DataScrapper
  class CategoryScrapper
    def initialize(service)
      @guest_id = service.guest_id
    end

    def getCategory; end

    def getMoviesCategories
      url = "https://api.themoviedb.org/3/genre/movie/list?api_key=#{ENV['TMDB_API_KEY']}&language=ru"
      data = JSON.parse(URI.open(url).read)
      data['genres'].each do |category|
        Category.create(name: category['name'])
      end
    end

    def getSerialsCategories
      url = "https://api.themoviedb.org/3/genre/tv/list?api_key=#{ENV['TMDB_API_KEY']}&language=ru"
      data = JSON.parse(URI.open(url).read)
      data['genres'].each do |category|
        Category.create(name: category['name'])
      end
    end
  end
end
