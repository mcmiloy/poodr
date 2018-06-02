class Gear
    attr_reader :chainring, :cog, :wheel #, :rim, :tire

    def initialize(chainring, cog, wheel)
        @chainring = chainring
        @cog = cog
        @wheel = wheel
    end
    
    def gear_inches
        ratio * diameter
    end

    def diameter
        wheel.diameter
    end

    def ratio
        chainring / cog.to_f
    end

    # def wheel
    #     @wheel ||= Wheel.new(rim, tire)
    # end

end


class Wheel
    attr_reader :rim, :tire
    def initialize(rim, tire)
        @rim = rim
        @tire = tire
    end

    def diameter
        rim + (tire * 2)
    end

    def circumference
        2 * diameter * Math::PI
    end
end

puts Gear.new(52, 11, Wheel.new(26, 1.5)).gear_inches # Dependency injection is good

