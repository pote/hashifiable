# Hashifiable [![Build Status](https://travis-ci.org/pote/hashifiable.png?branch=master)](https://travis-ci.org/pote/hashifiable) [![Code Climate](https://codeclimate.com/github/pote/hashifiable.png)](https://codeclimate.com/github/pote/hashifiable) <script data-gratipay-username="pote"
  data-gratipay-widget="button"
  src="//grtp.co/v1.js">
</script>

With Hashifiable you can specify a line with the methods that will be called to create a hash representation
of your object. Simple and straightforward.

## How it works

```ruby
require 'hashifiable'

class User < Struct.new(:id, :name, :state, :private_data, :more_private_data)
  extend Hashifiable
  hashify :id, :name, :state
end

user = User.new(1, 'pote', 'active', 'real credit card number', 'super secret token')

user.to_h     # Yes, #to_hash works too, but be good and use to_h. :)
#=> {:id=>1, :name=>"pote", :state=>"active"}
```

As simple as that, I find most gems with similar functionality to simply do too much, Hashifiable provides a minimum interface
to solve the problem of object representation (mostly to be used in APIs) without too much fuzz.

#### Passing Procs and lambdas

You can also declare a Proc or a lambda instead of just specifying a method name.

```ruby
class User < ActiveRecord::Base

  has_many :hobbies

  extend Hashifiable
  hashify :id,
          :name,
          :hobbies => Proc.new { hobbies.map(:&to_hash) },
          :right_now => lambda { Time.now }
end
```

#### Complex structures

If you want to define whatever complex structure to be included you can simply define a method in your object that returns said structure and include it by name in the `hashify` statement. Like so:

```ruby
class User < ActiveRecord::Base
  has_many :activity_logs

  extend Hashifiable
  hashify :id, :name, :activity

  def activity
  {
    logs: self.activity_logs.map(&:to_h),
    appointments: self.appointments.map(&:to_h),
    random: {
      i_am_a_key: 'And I am a value',
      bacon:  'cats'
    }
  }
  end
end
```

## Installation

```
$ gem install hashifiable
```

#### Development setup

```
$ bundle install
$ rspec
```

## Thanks

* To [@soveran](http://github.com/soveran) for an alternative and prettier implementation than the one I had came up with originally.
* To [@tizoc](http://github.com/tizoc) for great constructive criticism and pointing me towards instance_exec, of which I didn't know about. :)
* To all [contributors](https://github.com/pote/hashifiable/graphs/contributors)
