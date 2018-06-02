class Bicycle
    attr_reader :size, :chain, :tire_size

    def initialize(args={})
        @size = args[:size]
        @chain = args.fetch(:chain, default_chain)
        @tire_size = args.fetch(:tire_size, default_tire_size)
    end

    def spares
        {tire_size: tire_size,
         chain: chain}
    end

    def default_chain
        '10-speed'
    end


end

class RoadBike < Bicycle
    attr_reader :tape_color, :tire_size

    def initialize(args)
        @tape_color = args[:tape_color]
        super(args)
    end

    def spares
        super.merge({ tape_color: tape_color })
    end

    def default_tire_size
        '23'
    end

end

class MountainBike < Bicycle
    attr_reader :shock, :tire_size

    def initialize(args)
        @shock = args[:shock]
        super(args) # handles arguments common to all bicycles
    end

    def spares
        super.merge({shock: shock})
    end

    def default_tire_size
        '2.1'
    end

end


mybike = RoadBike.new({size: 'M', tape_color: 'R'})
puts mybike.chain
puts mybike.tire_size
puts mybike.spares

myMTB = MountainBike.new({size: 'L', shock: 'Fox'})
puts myMTB.chain
puts myMTB.tire_size
puts myMTB.spares

