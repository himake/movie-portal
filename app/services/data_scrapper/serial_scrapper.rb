module DataScrapper
  class SerialScrapper
    def initialize(service)
      @guest_id = service.guest_id
    end

    def get_serials_list(page, p_s, season_s, series_sc)
      url = "https://api.themoviedb.org/3/tv/popular?api_key=#{ENV['TMDB_API_KEY']}&language=ru&page=#{page}"
      data = JSON.parse(URI.open(url).read)
      data["results"].each do |el|
        get_serial(el["id"], p_s, season_s, series_sc)
      end
    end

    def get_serial(id, p_s, season_s, series_sc)
      url = "https://api.themoviedb.org/3/tv/#{id}?api_key=#{ENV['TMDB_API_KEY']}&language=ru&append_to_response=#{@guest_id}"
      data = JSON.parse(URI.open(url).read)
      credits = get_credits(data['id'])
      director = p_s.get_director(credits["crew"])
      if data["genres"][0].nil?
        genre = "Drama"
      else 
        genre = data['genres'][0]['name']
      end
      video = get_video(id)
      serial = Serial.create(name: data["name"], description: data["overview"], image: data["poster_path"], video_key: video, release_date: data["first_air_date"], category: Category.find_by(name: genre), director: director)
      data["seasons"].each do |el|
        season_s.get_season(el["season_number"], serial.id, id, p_s, series_sc)
      end
    end

    def get_video(id)
      url = "https://api.themoviedb.org/3/tv/#{id}/videos?api_key=#{ENV['TMDB_API_KEY']}&language=ru"
      video = JSON.parse(URI.open(url).read)
      video = JSON.parse(URI.open(url).read)
      return "" if video['results'].empty?
      video['results'][0]['key']
    end

    def get_credits(id)
      url = "https://api.themoviedb.org/3/tv/#{id}/credits?api_key=#{ENV['TMDB_API_KEY']}&language=ru&append_to_response=#{@guest_id}"
      JSON.parse(URI.open(url).read)
    end
  end
end