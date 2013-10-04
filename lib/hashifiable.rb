module Hashifiable

  def hashify(*args)

    ## Defines to_hash method dinamically with the key/values specified
    ## in *args.
    define_method :to_h do
      hash_representation = {}

      args.each do |argument|
        case argument
        when Symbol
          ## Calls the specified method on the object and stores it
          ## under the method name.
          hash_representation[argument] = self.send(argument)
        when Hash
          ## Takes the key of the hash passed as the key in the object's
          ## hash, the Proc/lambda is called in the context of the object
          ## to provide the value in the hash.
          argument.each do |name, function|
            hash_representation[name] = instance_exec(&function)
          end
        else raise ArgumentError
        end
      end

      hash_representation
    end

    alias_method :to_hash, :to_h
  end
end
