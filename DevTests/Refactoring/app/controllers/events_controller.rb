class EventsController < ApplicationController
  def index
    @event_categories = categories
    @events = filtered_events
  end

  private

  def categories
    current_user.event_categories.select(:id, :name)
  end

  def filtered_events
    EventFilter.call(current_user.events, event_params)
  end

  def event_params
    params.permit({ filter: [ :event_category_id, :type ] }, :sort, :query)
  end
end
