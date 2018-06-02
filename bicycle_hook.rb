module Schedulable
    attr_writer :schedule

    def schedule
        @schedule ||= ::Schedule.new
    end

    def schedulable?(start_date, end_date)
        !scheduled?(start_date - lead_days, end_date)
    end

    def scheduled?(start_date, end_date)
        schedule.scheduled?(self, start_date, end_date)
    end

    #includers may override
    def lead_days
        0
    end
end

class Bicycle
    include Schedulable
    
    attr_reader :schedule, :size, :chain, :tire_size

    def initialize(args={})
        @schedule = args[:schedule] || Schedule.new
        @size = args[:size]
        @chain = args[:chain] || default_chain
        @tire_size = args[:tire_size] || default_tire_size
        post_initialize(args)
    end

    def lead_days
        1
    end

    def spares
        {tire_size: tire_size,
         chain: chain}.merge(local_spares)
    end

    def post_initialize(args)
        nil
    end

    def local_spares 
        {}
    end

    def default_chain
        '10-speed'
    end



end

class RoadBike < Bicycle
    attr_reader :tape_color

    def post_initialize(args)
        @tape_color = args[:tape_color]
    end

    def local_spares
        {tape_color: tape_color}
    end

    def default_tire_size
        '23'
    end

end

class MountainBike < Bicycle
    attr_reader :front_shock, :rear_shock

    def post_initialize(args)
        @front_shock = args[:front_shock]
        @rear_shock = args[:rear_shock]
    end

    def local_spares
        {rear_shock: rear_shock}
    end

    def default_tire_size
        '2.1'
    end

end

class RecumbentBike < Bicycle
    attr_reader :flag

    def post_initialize(args)
        @flag = args[:flag]
    end

    def local_spares
        {flag: flag}
    end

    def default_chain
        '9-speed'
    end

    def default_tire_size
        '28'
    end
    
end
    

class Schedule
    def scheduled?(schedulable, start_date, end_date)
        puts "This #{schedulable.class} " +
             "is not scheduled\n" +
             "between #{start_date} and #{end_date}"
        return false
    end
end


require 'date'
starting = Date.parse("2015/09/05")
ending = Date.parse("2015/09/10")

b = MountainBike.new
b.schedulable?(starting, ending)