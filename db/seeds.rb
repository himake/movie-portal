# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first

Director.__elasticsearch__.create_index!(force: true)
Actor.__elasticsearch__.create_index!(force: true)
Serial.__elasticsearch__.create_index!(force: true)
Movie.__elasticsearch__.create_index!(force: true)

service = DataScrapper::ServiceScrapper.new(ENV['TMDB_SESSION_URL'])
service.set_guest_id

person_scrapper = DataScrapper::PersonScrapper.new(service)
category_scrapper = DataScrapper::CategoryScrapper.new(service)
category_scrapper.getSerialsCategories
category_scrapper.getMoviesCategories
m_s = DataScrapper::MovieScrapper.new(service)
m_s.get_popular(person_scrapper, 1)
serial_scrapper = DataScrapper::SerialScrapper.new(service)
season_s = DataScrapper::SeasonScrapper.new(service)
series_sc = DataScrapper::SeriesScrapper.new(service)
serial_scrapper.get_serials_list(1, person_scrapper, season_s, series_sc)



