require 'minitest/autorun'


class Trip
    attr_reader :bicycles, :customers, :vehicle
  
    def initialize(args={})
      @bicycles  = args[:bicycles]  ||= []
      @customers = args[:customers] ||= []
      @vehicles  = args[:vehicle]
    end
  
    def prepare(preparers)
      preparers.each {|preparer|
        preparer.prepare_trip(self)}
    end
end


class Mechanic
    def prepare_trip(trip)
      trip.bicycles.each {|bicycle|
        prepare_bicycle(bicycle)}
    end
  
    def prepare_bicycle(bicycle)
        puts 'preparing bycicle'
    end
end
  
class TripCoordinator
    def prepare_trip(trip)
      buy_food(trip.customers)
    end
  
    def buy_food(customers)
        puts 'buying food'
    end
end
  
class Driver
    def prepare_trip(trip)
      vehicle = trip.vehicle
      gas_up(vehicle)
      fill_water_tank(vehicle)
    end
    
    def gas_up(vehicle)
        puts 'fueling up vehicle'
    end

    def fill_water_tank(vehicle)
        puts 'filling up water tank'
    end
end


module PreparerInterfaceTest
    def test_implements_the_preparer_interface
      assert_respond_to(@object, :prepare_trip)
    end
end

class MechanicTest < MiniTest::Unit::TestCase # test if mechanic responds to :prepare_trip
  include PreparerInterfaceTest

  def setup
    @mechanic = @object = Mechanic.new
  end

  # other tests which rely on @mechanic
end

class TripCoordinatorTest < MiniTest::Unit::TestCase
    include PreparerInterfaceTest
  
    def setup
      @trip_coordinator = @object = TripCoordinator.new
    end
end


class DriverTest < MiniTest::Unit::TestCase # same as MiniTest::Test
    include PreparerInterfaceTest
  
    def setup
      @driver = @object =  Driver.new
    end
end


class TripTest < MiniTest::Unit::TestCase # test if Trip sends :prepare_trip

    def test_requests_trip_preparation
      @preparer = MiniTest::Mock.new
      @trip     = Trip.new
      @preparer.expect(:prepare_trip, nil, [@trip])

      @trip.prepare([@preparer])
      @preparer.verify
    end
end