class Gear
    attr_reader :chainring, :cog, :wheel
    def initialize(args)
        args = defaults.merge(args) # extremely verbose default
        @chainring = args[:chainring] # || 40 lazy setting default
        @cog = args[:cog] # .fetch(:cog, 18) # verbose default
        @wheel = args[:wheel]
    end

    def defaults
        {chainring: 40, cog: 18}
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

mygear = Gear.new ({
        :cog => 11,
        :chainring => 52,
        :wheel => Wheel.new(26, 1.5)
    })

puts mygear.gear_inches

puts nil || 42
