require 'forwardable'

class Bicycle
    attr_reader :size, :parts

    def initialize(args={})
        @size = args[:size]
        @parts = args[:parts]
    end

    def spares
        parts.spares
    end
end

class Parts
    extend Forwardable
    def_delegators :@parts, :size, :each
    include Enumerable
    attr_reader :parts

    def initialize(parts)
        @parts = parts
    end

    def spares
        parts.select {|part| part.needs_spare}
    end

end

class Part
    attr_reader :name, :description, :needs_spare

    def initialize(args)
        @name = args[:name]
        @description = args[:description]
        @needs_spare = args.fetch(:needs_spare, true)
    end

    def to_s
        "Name: #{name}, Description: #{description}"
    end
end

chain = Part.new({name: 'chain', description: '10-speed'})

road_tire = Part.new({name: 'tire_size', description: '23'})

tape = Part.new({name: 'tape_color', description: 'red'})

front_shock = Part.new({name: 'front_shock', description: 'fox'})

rear_shock = Part.new({name: 'front_shock', description: 'fox'})

mountain_tire = Part.new({name: 'tire_size', description: '2.1'})

road_bike_parts = Parts.new([chain, road_tire, tape])

road_bike = Bicycle.new({size: 'L', parts: road_bike_parts})

puts road_bike.spares


mountain_bike_parts = Parts.new([chain, mountain_tire, front_shock, rear_shock])

mountain_bike = Bicycle.new({size: 'L', parts: mountain_bike_parts})

puts mountain_bike.spares.size
puts mountain_bike.parts.size

