class Event < ActiveRecord::Base
  belongs_to :user
  belongs_to :event_category
  has_and_belongs_to_many :places

  scope :valid, -> { where('starts_at > ?', Time.current) }
  scope :expired, -> { where('starts_at <= ?', Time.current) }
  scope :category, -> id { where(event_category_id: id) }

  def self.by_place_id(place_id)
    where(places: {id: place_id}).joins(:places)
  end

  def self.full_text_search(query)
    where("name LIKE %?%", query)
  end
end
