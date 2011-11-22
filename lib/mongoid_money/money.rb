class Money < Numeric
  extend Mongoid::Extensions::Money::Conversions
  include Comparable
  include Mongoid::Fields::Serializable

  attr_reader :hundredths

  def self.new_from_ones(value)
    case value
      when Fixnum
        Money.new(value * 100)
      when BigDecimal
        Money.new((value * 100).fix)
      when Float
        #Money.new((BigDecimal.new(value.to_s) * 100).fix)
        Money.new(value * 100)
      when Numeric
        Money.new(value * 100)
      when String
        Money.new((BigDecimal.new(value.to_s) * 100).fix)
      else
        raise ArgumentError, "#{value} must be a numeric object or a string representation of a number."
    end
  end

  def self.new_from_hundredths(hundredths)
    Money.new hundredths.round.to_i
  end

  def initialize(hundredths)
    @hundredths = hundredths.round.to_i
  end

  def deserialize(value)
    return nil if value.blank?
    begin
      Money.new_from_hundredths value
    rescue
      nil
    end
  end

  def serialize(value)
    return nil if value.blank?
    begin
      value.hundredths
    rescue
      value
    end
  end

  def ones
    hundredths.to_f / 100.0
  end

  def ==(other_money)
    if other_money.respond_to?(:to_money)
      other_money = other_money.to_money
      hundredths == other_money.hundredths
    else
      false
    end
  end

  def eql?(other_money)
    self == other_money
  end

  def hash
    hundredths.hash
  end

  def <=>(other_money)
    if other_money.respond_to?(:to_money)
      other_money = other_money.to_money
      hundredths <=> other_money.hundredths
    else
      raise ArgumentError, "Comparison of #{self.class} with #{other_money.inspect} failed"
    end
  end

  def +(other_money)
    Money.new(hundredths + other_money.hundredths)
  end

  def -(other_money)
    Money.new(hundredths - other_money.hundredths)
  end

  def *(value)
    if value.is_a?(Money)
      raise ArgumentError, "Can't multiply a Money by a Money"
    else
      Money.new(hundredths * value)
    end
  end

  def /(value)
    if value.is_a?(Money)
      (hundredths / value.hundredths.to_f).to_f
    else
      Money.new(hundredths / value)
    end
  end

  def div(value)
    self / value
  end

  def divmod(val)
    if val.is_a?(Money)
      a = self.hundredths
      b = val.hundredths
      q, m = a.divmod(b)
      return [q, Money.new(m)]
    else
      return [self.div(val), Money.new(self.hundredths.modulo(val))]
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
    a_sign = :neg if a.hundredths < 0
    b_sign = :neg if (b.is_a?(Money) and b.hundredths < 0) or (b < 0)

    return a.modulo(b) if a_sign == b_sign
    a.modulo(b) - (b.is_a?(Money) ? b : Money.new(b))
  end

  def abs
    Money.new(self.hundredths.abs)
  end

  def zero?
    hundredths == 0
  end

  def nonzero?
    hundredths != 0 ? self : nil
  end

  def to_money
    self
  end

  def inspect
    to_s
  end

  def odd?
    @hundredths%2 > 0
  end

  def even?
    @hundredths%2 == 0
  end

  def to_s
    ones.to_s
  end

  def to_f
    ones
  end

  def coerce(other)
    return other, to_f
  end

end

class Numeric

  def one
    ones
  end

  def ones
    Money.new_from_ones self
  end

  def hundredth
    hundredths
  end

  def hundredths
    Money.new_from_hundredths self
  end

end
