class MorseCoder
  require 'morse'

  def initialize(separator="|", transmitter)
    print warn("transmitter does not respond to method 'puts'") if !transmitter.instance_methods(false).include?(:puts)
    @transmitter = transmitter.new
    @counter = 0
    @separator = separator
  end

  def counter_status
    @counter
  end

  def transmit(s)
    @transmitter.puts(self.encode(s))
  end

  def encode(s)
    increase_counter
    s.chars.map! {|c| MORSE[c]}.join(@separator)
  end
  def decode(s)
    increase_counter
    s.split(@separator).map!{|c| MORSE.invert[c]}.join("")
  end
  def method_missing(m)
    if m.size == 1
      increase_counter
      encode(m.to_s)
    end
  end

  private
  def increase_counter
    @counter += 1
  end
end

class VerifiableMorseCoder < MorseCoder
  def verify(s)
    s == decode(encode(s))
  end
end

class StandardTransmitter
  def puts(s)
    puts s
  end
end

class DebugTransmitter
  def puts(s)
    puts s.length, s.inspect
  end
end


class Bike
  @@directions = {"up!" => 1, "down!" => -1}
  def initialize(max_rear_gear, max_front_gear, name, wheel_size=26, *color)
    @max_rear_gear = max_rear_gear
    @max_front_gear = max_front_gear
    @rear_gear = 1
    @front_gear = 1
    @distance = 0
    @wheel_size = wheel_size
  end
  def current_gear
    "#{@rear_gear}x#{@front_gear}"
  end
  def go!
    @distance += @rear_gear*@front_gear*@wheel_size/10
  end
  def distance
    @distance
  end
  def action
    send (self.methods.select {|m| m.match(/\A(front|rear)_gear_(up|down)!\Z/)}+[:go!]*6).sample
  end
  def shift(gear, direction)
    p_value = instance_variable_get("@#{gear}")
    d_value = @@directions[direction]
    return if (p_value + d_value < 1 || p_value + d_value > instance_variable_get("@max_#{gear}"))
    instance_variable_set("@#{gear}", p_value + d_value)
  end
  def to_s
    "#{@name} (#{@wheel_size}): ran #{@distance}"
  end
  def method_missing(m)
    direction, gear = m.to_s.reverse!.split('_', 2).map {|i| i.reverse!}
    shift(gear, direction) if !instance_variable_get("@#{gear}").nil? && @@directions.key?(direction)
  end
end
