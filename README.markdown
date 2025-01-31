# mongoid_money
    
You really, really should use this gem
    https://github.com/RubyMoney/money

with this advice
    https://gist.github.com/840500
    
instead of this.

Or try my super small and simple money_field gem
    https://github.com/glebtv/mongoid_money_field


## Description

A simple gem that creates a Money datatype for Mongoid.

## Installation

Include the gem in your Gemfile

    gem 'mongoid_money', git: 'https://github.com/glebtv/mongoid_money'
    
## Usage

Now you can do things in your Mongoid documents like

    field :price, :type => Money, :default => 9.99.dollars

or 

    field :price, :type => Money, :default => 10.dollars

or

    field :price, :type => Money, :default => 99.cents

All Money values are converted and stored in mongo as cents.

You can also query against your Money fields. Just do the following:

    Item.where(:price => 5.dollars)

or

    Item.where(:price.gt => 10.dollars)



## Contributing to mongoid_money
 
* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet
* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it
* Fork the project
* Start a feature/bugfix branch
* Commit and push until you are happy with your contribution
* Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.
* Please try not to mess with the Rakefile, version, or history. If you want to have your own version, or is otherwise necessary, that is fine, but please isolate to its own commit so I can cherry-pick around it.

## Copyright

Copyright (c) 2011 Jeff Bozek. See LICENSE.txt for
further details.

