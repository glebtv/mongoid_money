class Money < Numeric
  include Comparable
  include Mongoid::Fields::Serializable

  attr_reader :cents

  def self.new_from_dollars(value)
    case value
      when Fixnum
        Money.new(value * 100)
      when BigDecimal
        Money.new((value * 100).fix)
      when Float
        Money.new(value * 100)
      when Money
        Money.new(value.cents)
      #when Numeric
      #  Money.new(value * 100)
      when String
        Money.new((BigDecimal.new(value.to_s) * 100).fix)
      else
        raise ArgumentError, "#{value} must be a numeric object or a string representation of a number."
    end
  end

  def self.new_from_cents(cents)
    Money.new cents.to_i
  end

  def initialize(cents)
    raise ArgumentError if cents.respond_to?(:nan?) && cents.nan?
    @cents = cents.to_i
  end

  def deserialize(value)
    Money.new_from_cents value
  end

  def serialize(value)
    begin
      value.cents
    rescue
      (Money.new_from_dollars value).cents
    end
  end

  def dollars
    cents.to_f / 100.0
  end

  def ==(other_money)
    if other_money.respond_to?(:to_money)
      other_money = other_money.to_money
      cents == other_money.cents
    else
      false
    end
  end

  def eql?(other_money)
    self == other_money
  end

  def hash
    cents.hash
  end

  def <=>(other_money)
    if other_money.respond_to?(:to_money)
      other_money = other_money.to_money
      cents <=> other_money.cents
    else
      raise ArgumentError, "Comparison of #{self.class} with #{other_money.inspect} failed"
    end
  end

  # Returns a money object with changed polarity.
  #
  # @return [Money]
  #
  # @example
  #    - Money.new(100) #=> #<Money @cents=-100>
  def -@
    Money.new(-cents)
  end


  def +(other_money)
    Money.new(cents + other_money.cents)
  end

  def -(other_money)
    Money.new(cents - other_money.cents)
  end

  def *(value)
    if value.is_a?(Money)
      raise ArgumentError, "Can't multiply a Money by a Money"
    else
      Money.new(cents * value)
    end
  end

  def /(value)
    if value.is_a?(Money)
      (cents / value.cents.to_f).to_f
    else
      Money.new(cents / value)
    end
  end

  def div(value)
    self / value
  end

  def divmod(val)
    if val.is_a?(Money)
      q, m = @cents.divmod(val.cents)
      return [q, Money.new(m)]
    else
      return [self.div(val), Money.new(@cents.modulo(val))]
    end
  end

  def modulo(val)
    self.divmod(val)[1]
  end

  def %(val)
    self.modulo(val)
  end

  def remainder(val)
    a, b = self, val

    a_sign, b_sign = :pos, :pos
    a_sign = :neg if a.cents < 0
    b_sign = :neg if (b.is_a?(Money) and b.cents < 0) or (!b.is_a?(Money) && b < 0)

    return a.modulo(b) if a_sign == b_sign
    a.modulo(b) - (b.is_a?(Money) ? b : Money.new(b))
  end

  def abs
    Money.new(@cents.abs)
  end

  def zero?
    @cents == 0
  end

  def nonzero?
    @cents != 0
  end

  def to_money
    self
  end

  def inspect
    to_s
  end

  def odd?
    @cents % 2 != 0
  end

  def even?
    @cents % 2 == 0
  end

  def to_i
    @cents
  end
  
  def to_s
    sprintf("%.2f", dollars.to_f)
  end

  def to_f
    dollars.to_f
  end

  def coerce(other)
     [self, other]
  end

end

class Numeric

  def dollar
    dollars
  end

  def dollars
    Money.new_from_dollars self
  end

  def cent
    cents
  end

  def cents
    Money.new_from_cents self
  end

end
