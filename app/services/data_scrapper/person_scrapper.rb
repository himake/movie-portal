module DataScrapper
  class PersonScrapper
    def initialize(service)
      @guest_id = service.guest_id
    end

    def get_person(id)
      url = "https://api.themoviedb.org/3/person/#{id}?api_key=#{ENV['TMDB_API_KEY']}&language=ru&append_to_response=#{@guest_id}"
      JSON.parse(URI.open(url).read)
    end

    def create_actor(data)
      return Actor.find_by(full_name: data['name']) if Actor.exists?(full_name: data['name'])

      Actor.create(full_name: data['name'], biography: data['biography'], date_of_birth: data['birthday'],
                   image: data['profile_path'], place_of_birth: data['place_of_birth'])
    end

    def create_director(data)
      return Director.find_by(full_name: data['name']) if Director.exists?(full_name: data['name'])

      Director.create(full_name: data['name'], biography: data['biography'], date_of_birth: data['birthday'],
                      image: data['profile_path'], place_of_birth: data['place_of_birth'])
    end

    def set_movie_actors(id, data)
      data.each do |el|
        actor = create_actor(get_person(el['id']))
        MoviesActor.create(movie: Movie.find(id), actor: actor)
      end
    end

    def set_season_actors(id, data)
      data.each do |el|
        actor = create_actor(get_person(el['id']))
        SeasonsActor.create(season: Season.find(id), actor: actor)
      end
    end

    def get_director(data)
        person = data.find { |el| el['job'] = 'Director' }
        return Director.find(1) if person.nil?
        create_director(get_person(person['id']))
    end
  end
end
