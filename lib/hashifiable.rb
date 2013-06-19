require 'json'

module Hashifiable
  def hashify(*args)
    ## Defines to_hash with specified arguments.
    define_method :to_hash do
      hash_representation = {}
      args.each do |attribute|
        hash_representation[attribute] = self.send(attribute)
      end

      hash_representation
    end

    ## Defines to_json based on the to_hash method.
    define_method :to_json do
      self.to_hash.to_json
    end
  end
end
