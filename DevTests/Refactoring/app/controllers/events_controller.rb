class EventsController < ApplicationController
  def index
    @event_categories = current_user.event_categories.
      select('event_categories.id, event_categories.name')

    @events           = self.filter_results
  end

  def filter_results
    places_count = current_user.places.count

    query = current_user.events.joins(:event_category).select(<<-SQL
        events.id,
        events.user_id,
        events.name,
        created_by,
        starts_at,
        ends_at,
        event_category_id,
        active,
        CASE
        WHEN global IS true THEN #{places_count}
        WHEN global IS false THEN array_length(place_ids, 1)
        END AS assigned_pos
      SQL
      ).preload(:event_category)

    query = query.order("#{params[:sort]}, events.name ASC")

    if params[:filters]
      query = filters_by_type(query)
      query = filters_by_place_id(query)
      query = filters_by_event_category_id(query)
    else
      query = query.none
    end

    if params[:place_id].present?
      query = query.by_place_id(params[:place_id].to_i)
    end

    query = query.full_text_search(params[:query]) if params[:query].present?

    query
  end

  ######################################################################
  # Filters
  ######################################################################
  def filters_by_type(query)
    return query.valid if params[:filters][:type].blank?

    case params[:filters][:type].try(:to_sym)
    when :all
      query
    when :valid, :expired
      query.send(params[:filters][:type])
    else
      query.valid
    end
  end

  def filters_by_place_id(query)
    return query if params[:filters][:place_id].blank?

    query.by_place_id(params[:filters][:place_id].to_i)
  end

  def filters_by_event_category_id(query)
    return query if params[:filters][:event_category_id].blank?

    query.where(:event_category_id => params[:filters][:event_category_id].to_i)
  end
end
