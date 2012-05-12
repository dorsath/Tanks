module Talisman
  class Event

    attr_reader :clock

    def initialize(clock = Time)
      @clock = clock
      trigger
    end

    def register(attrs)
      assign attrs
    end

    def x
      current :x
    end

    def y
      current :y
    end

    def key
      current :key
    end

    def type
      current :type
    end

    def history
      @history ||= []
    end

    def assign(attrs)
      history << attrs.merge(:time => clock.now)
    end

    def current(field)
      history.last && history.last[field]
    end

    def duration
      delta(:time)
    end

    def trigger
      assign(history.last || {})
    end

    def delta(field)
      changes(field).reverse.compact.inject(&:-)
    end

    def changes(field)
      all = all(field)
      [ all[-2], all[-1] ]
    end

    def total(field)
      all = all(field).compact
      [ all.last, all.first ].inject(&:-)
    end

    def all(field)
      history.map { |attr| attr[field] }
    end

  end
end
