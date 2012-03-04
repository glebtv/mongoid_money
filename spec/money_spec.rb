require 'spec_helper'

describe Money do
  
  describe "#==" do
    it 'should identify equal dollar values correctly' do
      (10.dollars == Money.new_from_dollars(10)).should eq true
      (10.dollars == 10.dollars).should eq true
    end
    
    it 'should identify equal monetary values correctly' do
      (10.dollars == Money.new_from_cents(10 * 100)).should eq true
      (10.dollars == 1000.cents).should eq true
    end
    
    it 'should not be equal to integers' do
      (10 == Money.new_from_dollars(10)).should eq false
      (1000 == Money.new_from_dollars(10)).should eq false
    end
    
    it 'should identify equal monetary values correctly' do
      (10.dollars == Money.new_from_cents(10 * 100)).should eq true
      (10.dollars == 1000.cents).should eq true
    end
    
    it '10.dollars is not 1.dollar' do
      (10.dollars == 1.dollar).should eq false
    end
    it '1.dollars is 1.dollar' do
      (1.dollars == 1.dollar).should eq true
    end
    it '10.dollars is 1.dollar * 10' do
      (10.dollars == 1.dollar * 10).should eq true
    end
    it '10.cents is not 1.cent' do
      (10.cents == 1.cent).should eq false
    end
    it '10.cents is 1.cent * 10' do
      (10.cents == 1.cent * 10).should eq true
    end
    it '1.cents is 1.cent' do
      (1.cents == 1.cent).should eq true
    end
  end
  
  describe "#eql?" do
    it 'should identify equal dollar values correctly' do
      (10.dollars.eql?(Money.new_from_dollars(10))).should eq true
      (10.dollars.eql?(10.dollars)).should eq true
    end
    
    it 'should identify equal monetary values correctly' do
      (10.dollars.eql?(Money.new_from_cents(10 * 100))).should eq true
      (10.dollars.eql?(1000.cents)).should eq true
    end
  end
  
  describe "#<=>" do
    it 'should find that 10 dollars is greater than 5 dollars' do
      (10.dollars <=> 5.dollars).should eq 1
    end
    
    it 'should find that 5 dollars is less than 10 dollars' do
      (5.dollars <=> 10.dollars).should eq -1
    end
    
    it 'should raise an error when Money is compared to non-money' do
      expect{ 5.dollars <=> 500}.to raise_error(ArgumentError, "Comparison of Money with 500 failed")
    end
  end
  
  describe "#+" do
    it 'should add 10 dollars and 5 dollars and get 15 dollars' do
      (10.dollars + 5.dollars).should eq 15.dollars
    end
    
    it 'should add 10 dollars and 200 cents and get 12 dollars' do
      (10.dollars + 200.cents).should eq 12.dollars
    end
    
    it 'should add 50 cents and 200 cents and get 250 cents' do
      (50.cents + 200.cents).should eq 250.cents
    end
  end
  
  describe "#-" do
    it 'should subtract 5 dollars from 15 dollars and get 10 dollars' do
      (15.dollars - 5.dollars).should eq 10.dollars
    end
    
    it 'should subtract 200 cents from 12 dollars and get 10 dollars' do
      (12.dollars - 200.cents).should eq 10.dollars
    end
    
    it 'should subtract 50 cents from 200 cents and get 150 cents' do
      (200.cents - 50.cents).should eq 150.cents
    end
  end
  
  describe "#*" do
    it 'should multiply 10 dollars by 3 and get 30 dollars' do
      (10.dollars * 3).should eq 30.dollars
    end
    
    it 'should raise an error when Money is multiplied by money' do
      expect{ 5.dollars * 5.dollars}.to raise_error(ArgumentError, "Can't multiply a Money by a Money")
    end
  end
  
  describe "#/" do
    it 'should divide 10 dollars by 2 and get 5 dollars' do
      (10.dollars / 2).should eq 5.dollars
    end
    
    it 'should divide 10 dollars by 5 dollars and get 2' do
      (10.dollars / 5.dollars).should eq 2
    end
  end
  
  describe "#div" do
    it 'should divide 10 dollars by 2 and get 5 dollars' do
      (10.dollars.div(2)).should eq 5.dollars
    end
    
    it 'should divide 10 dollars by 5 dollars and get 2' do
      (10.dollars.div(5.dollars)).should eq 2
    end
  end
  
  describe "#abs" do
    it 'should return the abs value of -10 dollars as 10 dollars' do
      -10.dollars.abs.should eq 10.dollars
    end
    
    it 'should return the abs value of 10 dollars as 10 dollars' do
      10.dollars.abs.should eq 10.dollars
    end
  end
  
  describe "#divmod" do
    it 'should divide 10 dollars by 2 and get 5 dollars' do
      (10.dollars.divmod(2))[0].should eq 5.dollars
    end
    
    it 'should divide 10 dollars by 5 dollars and get 2' do
      (10.dollars.divmod(5.dollars))[0].should be_within(0.1).of(2)
    end
  end
  
  describe "#inspect" do
    it 'should return correct string for dollars' do
      10.dollars.inspect.should eq "10.00"
      1.9.dollars.inspect.should eq "1.90"
      1.09.dollars.inspect.should eq "1.09"
      1.090.dollars.inspect.should eq "1.09"
    end
    it 'should return correct string for cents' do
      10.cents.inspect.should eq "0.10"
      1.cents.inspect.should eq "0.01"
      199.cents.inspect.should eq "1.99"
    end
  end
  
  describe "#odd" do
    it 'should return correct oddness for dollars' do
      (1.99.dollars.odd?).should be true
      (1.98.dollars.odd?).should be false
    end
    it 'should return correct oddness for cents' do
      (199.cents.odd?).should be true
      (198.cents.odd?).should be false
    end
  end
  
  describe "#even" do
    it 'should return correct oddness for dollars' do
      (1.99.dollars.even?).should be false
      (1.98.dollars.even?).should be true
    end
    it 'should return correct oddness for cents' do
      (199.cents.even?).should be false
      (198.cents.even?).should be true
    end
  end
  
  describe "#coerce" do
    it 'should coerce to integers' do
      (9 * 2.dollars).should eq 18.dollars
    end
    it 'should coerce to floats' do
      (1.2 * 2.dollars).should eq 2.4.dollars
      (1.2 * 9.dollars).should eq 10.80.dollars
    end
  end
  
  describe "#%" do
    it '10 dollars % 2 dollars is 0.dollars' do
      (10.dollars % 2.dollars).should eq 0.dollars
    end
    
    it '10 dollars % 3 dollars is 1.dollar' do
      (10.dollars % 3.dollars).should eq 1.dollars
    end
    
    it '11 dollars % -5 dollars is -4.dollars' do
      (11.dollars % -5.dollars).should eq -4.dollars
    end
  end
  
  describe "#modulo" do
    it '10 dollars modulo 2 dollars is 0.dollars' do
      (10.dollars.modulo(2.dollars)).should eq 0.dollars
    end
    
    it '10 dollars modulo 3 dollars is 1.dollar' do
      (10.dollars.modulo(3.dollars)).should eq 1.dollars
    end
    
    it '11 dollars modulo -5 dollars is -4.dollars' do
      (11.dollars.modulo(-5.dollars)).should eq -4.dollars
    end
  end
  
  describe "#remainder" do
    it "calculates remainder with Fixnum" do
      ts = [
          {:a => Money.new_from_cents( 13), :b =>  4, :c => Money.new_from_cents( 1)},
          {:a => Money.new_from_cents( 13), :b => -4, :c => Money.new_from_cents( 1)},
          {:a => Money.new_from_cents(-13), :b =>  4, :c => Money.new_from_cents(-1)},
          {:a => Money.new_from_cents(-13), :b => -4, :c => Money.new_from_cents(-1)},
      ]
      ts.each do |t|
        t[:a].remainder(t[:b]).should == t[:c]
      end
    end

    it "calculates remainder with Money" do
      ts = [
          {:a => Money.new_from_cents( 13), :b => Money.new_from_cents( 4), :c => Money.new_from_cents( 1)},
          {:a => Money.new_from_cents( 13), :b => Money.new_from_cents(-4), :c => Money.new_from_cents( 1)},
          {:a => Money.new_from_cents(-13), :b => Money.new_from_cents( 4), :c => Money.new_from_cents(-1)},
          {:a => Money.new_from_cents(-13), :b => Money.new_from_cents(-4), :c => Money.new_from_cents(-1)},
      ]
      ts.each do |t|
        t[:a].remainder(t[:b]).should == t[:c]
      end
    end
  end
  
  describe "#zero?" do
    it 'should be true for 0.cents' do
      (0.cents.zero?).should eq true
    end
    
    it 'should be false for 1.cent' do
      (1.cent.zero?).should eq false
    end
  end
  
  describe "#nonzero?" do
    it 'should be false for 0.cents' do
      (0.cents.nonzero?).should eq false
    end
    
    it 'should be true for 1.cent' do
      (1.cent.nonzero?).should eq true
    end
  end
  
  describe "#to_i" do
    it 'should return value as cents' do
      (0.cents.to_i).should eq 0
      (1.dollars.to_i).should eq 100
    end
  end
  
  describe "#to_f" do
    it 'should return value as dollars' do
      (0.cents.to_f).should eq 0.0
      (1.dollars.to_f).should eq 1.00
    end
  end
  
  describe "#-" do
    it 'should return inverse polarity money' do
      (-(1.cent)).should eq ((-1).cent)
      (-(1.dollar)).should eq ((-1).dollar)
    end
  end
  
  describe "#hash" do
    it 'should not be nil' do
      1.cent.hash.should_not be nil
    end
    it 'should be the same for different instances' do
      (1.cent.hash == 1.cent.hash).should eq true
    end
    it 'should be different for different values' do
      (2.cent.hash == 1.cent.hash).should eq false
    end
    it 'should be the same for different instances' do
      (Money.new_from_cents(1).hash == Money.new_from_cents(1).hash).should eq true
    end
  end
    
  
  describe "#new_from_dollars" do
    it 'should create money objects from strings' do
      m = Money.new_from_dollars "1.23"
      m.should eq 1.23.dollars
    end
    
    it 'should create money objects from floats' do
      m = Money.new_from_dollars 1.23
      m.should eq 1.23.dollars
    end
    
    it 'should create money objects from Money' do
      m = Money.new_from_dollars(Money.new_from_dollars 1.23)
      m.should eq 1.23.dollars
    end
    
    it 'should create money objects from integers' do
      m = Money.new_from_dollars 123
      m.should eq 123.dollars
      m.should eq 12300.cents
    end
    
    it 'should create money objects from BigDecimal' do
      d = BigDecimal.new('1.23')
      m = Money.new_from_dollars d
      m.should eq 1.23.dollars
    end
    
    it 'should not create money objects from Array' do
      lambda {
        m = Money.new_from_dollars [1, 2]
      }.should raise_error(ArgumentError)
    end
    
    it 'should not create money objects from hashes' do
      lambda {
        m = Money.new_from_dollars({ dollars: 12 })
      }.should raise_error(ArgumentError)
    end
    
    it 'drops extra precision' do
      9.999.dollars.should eq 9.99.dollars
      9.99.dollars.should eq 9.99.dollars
      9.99999.dollars.should eq 9.99.dollars
    end
  end
  
  describe "#new_from_cents" do
    it 'should create money objects from integers' do
      m = Money.new_from_cents 123
      m.should eq 1.23.dollars
    end
  end
end
