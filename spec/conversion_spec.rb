require 'spec_helper'

describe Mongoid::Extensions::Money::Conversions do
  
  describe 'when persisting a document with a Money datatype' do
  
    it 'should be persisted normally when set as ones' do
      dummy = DummyMoney.new
      dummy.price = 10.ones
      dummy.save.should eq true
    end
    
    it 'should be persisted normally when set as hundredths' do
      dummy = DummyMoney.new
      dummy.price = 99.hundredths
      dummy.save.should eq true
    end
    
  end
  
  describe 'when accessing a document from the datastore with a Money datatype' do
    
    before(:each) do
      DummyMoney.create(:description => "Test", :price => 9.ones)
    end
    
    it 'should have a Money value that matches the money value that was initially persisted' do
      dummy = DummyMoney.first
      dummy.price.should eq 9.ones
    end
    
  end

end