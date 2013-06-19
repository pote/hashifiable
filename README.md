# Hashifiable

A simple way to specify the hash/json representation of your object
[![Build Status](https://travis-ci.org/pote/hashifiable.png?branch=master)](https://travis-ci.org/pote/hashifiable)

#### TL;DR

With hashifiable you can specify a line with the methods that will be called to
create a hash representation of your object. Simple and straightforward.

## How it works

```ruby
require 'hashifiable'

class User < Struct.new(:id, :name, :state, :private_data, :more_private_data)
  extend Hashifiable
  hashify :id, :name, :state
end

user = User.new(1, 'pote', 'active', 'real credit card number', 'super secret token')

user.to_hash
#=> {:id=>1, :name=>"pote", :state=>"active"}

user.to_json
#=> "{\"id\":1,\"name\":\"pote\",\"state\":\"active\"}"
```

As simple as that, I find most gems with similar functionality to simply do too much, Hashifiable provides a minimum interface
to solve the problem of object representation (mostly to be used in APIs) without too much fuzz.

**Note**: I would recommend that every item in the `hashify` call to be hashes, arrays, strings, symbols and the like. Hashifiable also adds
a `#to_json` method to your object and for that to work all the values should be json-serializable. 

If you want to define whatever complex structure to be included you can simply define a method in your object that returns said structure as a hash/array/whatever and include it by name in the `hashify` statement. Like so:

```ruby
class User < ActiveRecord::Base
  has_many :activity_logs

  extend Hashifiable
  hashify :id, :name, :activity

  def activity
    self.activity_logs.map(&:to_hash)
  end
end
```

## Installation

```
$ gem install hashify
```

#### Development setup

```
$ bundle install
$ rspec
```
