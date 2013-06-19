# Hashify

A simple way to specify the hash/json representation of your object

#### TL;DR

With hashify you can specify a line with the methods that will be called to
create a hash representation of your object. Simple and straightforward.

## How it works

```ruby
require 'hashify'

class User < Struct.new(:id, :name, :state, :private_data, :more_private_data)
  hashify :id, :name, :state
end

user = User.new(1, 'pote', 'active', 'real credit card number', 'super secret token')

user.to_hash
#=> {:id=>1, :name=>"pote", :state=>"active"}

user.to_json
#=> "{\"id\":1,\"name\":\"pote\",\"state\":\"active\"}"
```

As simple as that, I find most gems with similar functionality to be overkill, if you want to define complex subhashes to be included you can simply define a method in your object that returns said hash with the appropriate name and include it by name in the `hashify` statement.

## Installation

```
$ gem install hashify
```
