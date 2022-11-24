module DataScrapper
  class SeasonScrapper
    def initialize(service)
      @guest_id = service.guest_id
    end

    def get_season(season_number, sid, serial_id, p_s, series_sc)
      url = "https://api.themoviedb.org/3/tv/#{serial_id}/season/#{season_number}?api_key=#{ENV['TMDB_API_KEY']}&language=ru&append_to_response=#{@guest_id}"
      data = JSON.parse(URI.open(url).read)
      credits = get_credits(season_number, serial_id)
      video = get_video(serial_id, season_number)
      season = Season.create(name: data["name"], description: data["overview"], image: data["poster_path"], video_key: video, number: data["season_number"], serial: Serial.find(sid))
      p_s.set_season_actors(season.id, credits["cast"])
      data["episodes"].each do |el|
        series_sc.getSeries(el["episode_number"], serial_id, season.id, season_number)
      end
    end

    def get_video(serial_id, id)
      url = "https://api.themoviedb.org/3/tv/#{serial_id}/season/#{id}/videos?api_key=#{ENV['TMDB_API_KEY']}&language=ru"
      video = JSON.parse(URI.open(url).read)
      return "" if video['results'].empty?
      video['results'][0]['key']
    end

    def get_credits(season_number, serial_id)
      url = "https://api.themoviedb.org/3/tv/#{serial_id}/season/#{season_number}/credits?api_key=#{ENV['TMDB_API_KEY']}&language=ru"
      JSON.parse(URI.open(url).read)
    end
  end
end