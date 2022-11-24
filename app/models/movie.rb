require 'elasticsearch/model'

class Movie < ApplicationRecord
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks
  include ElasticMyAnalyzer

  belongs_to :category
  belongs_to :director
  has_many :movies_country
  has_many :countries, through: :movies_country
  has_many :movies_actor
  has_many :actors, through: :movies_actor
  has_many :likes, as: :likeable
  has_many :liked_users, through: :like
  has_many :wishes, as: :wishable
  has_many :wished_users, through: :wish
  has_many :comments, as: :commentable

  paginates_per 4

  settings ES_SETTING do
    mappings dynamic: 'true' do
      indexes :name, analyzer: 'my_analyzer'
    end
  end

  def as_indexed_json(_params = {})
    {
      name: name,
      image: image,
      description: description,
      release_date: release_date,
      duration: duration,
      category_id: category_id,
      director_id: director_id
    }
  end

  def self.search_published(query)
    __elasticsearch__.search(query: {
                               bool: {
                                 must: {
                                   multi_match: {
                                     query: query,
                                     fields: %w[name full_name],
                                     operator: 'and'
                                   }
                                 }
                               }
                             }).results
  end
end
