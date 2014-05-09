class User < ActiveRecord::Base
  has_many :events
  has_many :event_categories, through: :events
  has_many :places, through: :events
end
