require 'talisman/event'

module Talisman
  class Controller

    # TODO deprecate the use of anything other than hash as parameter
    def self.on(id_or_key, &action)
      if id_or_key.is_a?(Hash)
        id = id_or_key
      else
        warn "DEPRECATION: use a hash to define an event handler: on key: '#{id_or_key}' do |event|"
        id = { key: id_or_key }
      end
      if callbacks.has_key?(id)
        warn "Warning: already assigned event #{id.inspect} on #{self.name}"
      end
      callbacks[id] = action
    end

    def self.callbacks
      @callbacks ||= {}
    end

    def key_press(key, x, y)
      events[key: key].register(type: :key, key: key, x: x, y: y)
    end
    alias_method :special_key_press, :key_press

    def key_up(key, x, y)
      events.delete(key: key)
    end
    alias_method :special_key_up, :key_up

    def callbacks
      self.class.callbacks
    end

    def on_tick
      # no op
    end

    def events
      @events ||= Hash.new { |h,k| h[k] = Event.new }
    end

    attr_accessor :window

    def fire_events
      call_callbacks
      on_tick
    end

    def call_callbacks
      events.each do |id, event|
        callback = callbacks[id]
        event.trigger
        instance_exec(event, &callback) if callback
      end
    end

  end
end
