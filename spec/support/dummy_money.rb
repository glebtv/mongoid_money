class DummyMoney
  include Mongoid::Document

  field :description
  field :price, type: Money, default: 5.cents

end