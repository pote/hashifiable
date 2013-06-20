require 'json'

module Hashifiable

  def hashify(*args)

    ## Defines to_hash method dinamically with the key/values specified in *args.
    define_method :to_h do
      hash_representation = {}

      methods = args.select { |a| a.is_a?(Symbol) }
      procs   = args.select { |a| a.is_a?(Hash)   }.inject { |all, hash| all.merge(hash) }

      ## Create keys for all lambdas sent.
      procs.each do |name, function|
        hash_representation[name] = instance_exec(&function)
      end

      ## Create keys for all methods specified.
      methods.each do |attribute|
        hash_representation[attribute] = self.send(attribute)
      end

      hash_representation
    end
    alias_method :to_hash, :to_h

    ## Defines to_json based on the to_hash method.
    define_method :to_json do
      self.to_hash.to_json
    end
  end
end
