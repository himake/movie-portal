module DataScrapper
  class SeriesScrapper
    def initialize(service)
      @guest_id = service.guest_id
    end

    def getSeries(episode_number, serial_id, season_id, season_number)
      url = "https://api.themoviedb.org/3/tv/#{serial_id}/season/#{season_number}/episode/#{episode_number}?api_key=#{ENV['TMDB_API_KEY']}&language=ru&append_to_response=#{@guest_id}"
      data = JSON.parse(URI.open(url).read)
      credits = getCredits(episode_number, serial_id, season_number)
      seria = Series.create(name: data["name"], description: data["overview"], image: data["still_path"], number: data["episode_number"], season: Season.find(season_id))
      seria.save
    end

    def getCredits(id, serial_id, season_number)
      url = "https://api.themoviedb.org/3/tv/#{serial_id}/season/#{season_number}/episode/#{id}/credits?api_key=#{ENV['TMDB_API_KEY']}&language=ru&append_to_response=#{@guest_id}"
      JSON.parse(URI.open(url).read)
    end
  end
end