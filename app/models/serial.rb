class Serial < ApplicationRecord
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks
  include ElasticMyAnalyzer

  belongs_to :category
  belongs_to :director
  has_many :seasons

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
end
