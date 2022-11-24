class Actor < ApplicationRecord
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks
  include ElasticMyAnalyzer

  paginates_per 4

  has_many :movies_actor
  has_many :movies, through: :movies_actor
  has_many :seasons_actor
  has_many :seasons, through: :seasons_actor

  settings ES_SETTING do
    mappings dynamic: 'true' do
      indexes :full_name, analyzer: 'my_analyzer'
    end
  end
end
