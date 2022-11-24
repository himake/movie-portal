class Director < ApplicationRecord
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks
  include ElasticMyAnalyzer

  has_many :movies
  has_many :serials

  settings ES_SETTING do
    mappings dynamic: 'true' do
      indexes :full_name, analyzer: 'my_analyzer'
    end
  end
end
