require 'spec_helper'

describe Money do
  
  describe "#==" do
    it 'should identify equal ones values correctly' do
      (10.ones == Money.new_from_ones(10)).should eq true
      (10.ones == 10.ones).should eq true
    end
    
    it 'should identify equal monetary values correctly' do
      (10.ones == Money.new_from_hundredths(10 * 100)).should eq true
      (10.ones == 1000.hundredths).should eq true
    end
  end
  
  describe "#eql?" do
    it 'should identify equal ones values correctly' do
      (10.ones.eql?(Money.new_from_ones(10))).should eq true
      (10.ones.eql?(10.ones)).should eq true
    end
    
    it 'should identify equal monetary values correctly' do
      (10.ones.eql?(Money.new_from_hundredths(10 * 100))).should eq true
      (10.ones.eql?(1000.hundredths)).should eq true
    end
  end
  
  describe "#<=>" do
    it 'should find that 10 ones is greater than 5 ones' do
      (10.ones <=> 5.ones).should eq 1
    end
    
    it 'should find that 5 ones is less than 10 ones' do
      (5.ones <=> 10.ones).should eq -1
    end
    
    it 'should raise an error when Money is compared to non-money' do
      expect{ 5.ones <=> 500}.to raise_error(ArgumentError, "Comparison of Money with 500 failed")
    end
  end
  
  describe "#+" do
    it 'should add 10 ones and 5 ones and get 15 ones' do
      (10.ones + 5.ones).should eq 15.ones
    end
    
    it 'should add 10 ones and 200 hundredths and get 12 ones' do
      (10.ones + 200.hundredths).should eq 12.ones
    end
    
    it 'should add 50 hundredths and 200 hundredths and get 250 hundredths' do
      (50.hundredths + 200.hundredths).should eq 250.hundredths
    end
  end
  
  describe "#-" do
    it 'should subtract 5 ones from 15 ones and get 10 ones' do
      (15.ones - 5.ones).should eq 10.ones
    end
    
    it 'should subtract 200 hundredths from 12 ones and get 10 ones' do
      (12.ones - 200.hundredths).should eq 10.ones
    end
    
    it 'should subtract 50 hundredths from 200 hundredths and get 150 hundredths' do
      (200.hundredths - 50.hundredths).should eq 150.hundredths
    end
  end
  
  describe "#*" do
    it 'should multiply 10 ones by 3 and get 30 ones' do
      (10.ones * 3).should eq 30.ones
    end
    
    it 'should raise an error when Money is multiplied by money' do
      expect{ 5.ones * 5.ones}.to raise_error(ArgumentError, "Can't multiply a Money by a Money")
    end
  end
  
  describe "#/" do
    it 'should divide 10 ones by 2 and get 5 ones' do
      (10.ones / 2).should eq 5.ones
    end
    
    it 'should divide 10 ones by 5 ones and get 2' do
      (10.ones / 5.ones).should eq 2
    end
  end
  
  describe "#div" do
    it 'should divide 10 ones by 2 and get 5 ones' do
      (10.ones.div(2)).should eq 5.ones
    end
    
    it 'should divide 10 ones by 5 ones and get 2' do
      (10.ones.div(5.ones)).should eq 2
    end
  end
  
  describe "#abs" do
    it 'should return the abs value of -10 ones as 10 ones' do
      -10.ones.abs.should eq 10.ones
    end
    
    it 'should return the abs value of 10 ones as 10 ones' do
      10.ones.abs.should eq 10.ones
    end
  end
  
end
