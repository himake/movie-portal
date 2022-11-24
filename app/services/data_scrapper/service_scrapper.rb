module DataScrapper
  class ServiceScrapper
    attr_reader :guest_id

    def initialize(session_url)
      @url = session_url
      @guest_id = nil
    end

    def set_guest_id
      data = JSON.parse(URI.open(@url + "api_key=#{ENV['TMDB_API_KEY']}").read)
      @guest_id = data['guest_session_id']
    end
  end
end
