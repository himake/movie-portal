module DataScrapper
  class CountryScrapper
    def initialize(service)
      @guest_id = service.guest_id
    end

    def getCountries
      url = "https://api.themoviedb.org/3/configuration/countries?api_key=#{ENV['TMD_TOKEN']}&language=ru&append_to_response=#{ENV['GUEST_SESSION_ID']}"
      data = JSON.parse(URI.open(url).read)
      data.each do |country|
        if !Country.exists?(name: data['english_name']) && country['english_name'].nil?
          Country.create(name: country['english_name'])
        end
      end
    end
  end
end
