class EventFilter
  def initialize(events, params)
    @events, @params, @response = events, params, []
  end

  def self.call(events, params)
    new(events, params).relation
  end

  def relation
    query_classes.each(&execute) && @response
  end

  private

  def execute
    -> query_class { query_class.relation(query, @params).tap(&assign) }
  end

  def assign
    -> value { @response &&= value if value }
  end

  def query_classes
    [Select, Order, Type, Category, Text]
  end

  def query
    @query ||= @events.joins(:event_category)
  end

  class Base
    def initialize(query, params)
      @query, @params = query, params
    end

    def self.relation(query, params)
      new(query, params).relation
    end

    def relation
      raise NotImplementedError, "Inheriting class must implement 'relation'"
    end

    private
    attr_reader :query, :params

    def filter
      params.fetch(:filters, {})
    end
  end

  class Select < Base
    def relation
      query.select!(keys).preload(:event_category)
    end

    def keys
      [
        'events.id',
        'events.user_id',
        'events.name',
        'created_by',
        'starts_at',
        'ends_at',
        'event_category_id',
        'active'
      ].join(', ')
    end
  end

  class Order < Base
    def relation
      query.order!("#{sort}, events.name ASC")
    end

    def sort
      @params.fetch(:sort, 'events.id')
    end
  end

  class Type < Base
    def relation
      query.public_send(type)
    rescue TypeError, NoMethodError
      query.valid
    end

    def type
      filter.fetch(:type, :all)
    end
  end

  class Category < Base
    def relation
      query.valid.category(id) if id
    end

    def id
      filter[:event_category_id]
    end
  end

  class Text < Base
    def relation
      query.full_text_search(text) if text
    end

    def text
      params[:query]
    end
  end
end
