module DataScrapper
  class MovieScrapper
    def initialize(service)
      @guest_id = service.guest_id
    end

    def get_list(id, p_s)
      url = "https://api.themoviedb.org/3/list/#{id}?api_key=#{ENV['TMDB_API_KEY']}&language=ru"
      data = JSON.parse(URI.open(url).read)
      data['items'].each do |el|
        credits = get_credits(el['id'])
        director = p_s.get_director(credits['crew'])
        video = get_video(el['id'])
        movie_data = get_movie(el['id'])
        movie = Movie.create(name: movie_data['title'], image: movie_data['poster_path'],
                            description: movie_data['overview'], release_date: movie_data['release_date'], 
                            duration: movie_data['run_time'], category: Category.find_by(name: movie_data['genres'][0]['name']), 
                            director: director, video_key: video['key'])
        p_s.set_movie_actors(movie.id, credits['cast'])
      end
    end

    def get_popular(p_s, page)
      url = "https://api.themoviedb.org/3/movie/popular?api_key=#{ENV['TMDB_API_KEY']}&language=ru&page=#{page}"
      data = JSON.parse(URI.open(url).read)
      data['results'].each do |el|
        credits = get_credits(el['id'])
        director = p_s.get_director(credits['crew'])
        movie_data = get_movie(el['id'])
        video = get_video(el['id'])
        movie = Movie.create(name: movie_data['title'], image: movie_data['poster_path'],
                            description: movie_data['overview'], release_date: movie_data['release_date'], 
                            duration: movie_data['run_time'], category: Category.find_by(name: movie_data['genres'][0]['name']), 
                            director: director, video_key: video)
        p_s.set_movie_actors(movie.id, credits['cast'])
      end
    end

    def get_movie(id)
      url = "https://api.themoviedb.org/3/movie/#{id}?api_key=#{ENV['TMDB_API_KEY']}&language=ru"
      JSON.parse(URI.open(url).read)
    end

    def get_video(id) 
      url = "https://api.themoviedb.org/3/movie/#{id}/videos?api_key=#{ENV['TMDB_API_KEY']}&language=ru"
      video = JSON.parse(URI.open(url).read)
      return "" if video['results'].empty?
      video['results'].each do |info|
        return info['key'] if info['type'] == "Trailer" || info['type'] == "Teaser"
      end
      video['results'][0]['key']
    end

    def get_credits(id)
      url = "https://api.themoviedb.org/3/movie/#{id}/credits?api_key=#{ENV['TMDB_API_KEY']}&language=ru&append_to_response=#{@guest_id}"
      JSON.parse(URI.open(url).read)
    end
  end
end
