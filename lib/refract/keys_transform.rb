module Refract
  module KeysTransform
    def self.transform_hash(origin, &block)
      return origin unless origin.is_a?(Hash) || origin.is_a?(Array)

      origin.inject({}) do |result, (key, value)|
        value = if value.is_a?(Hash)
                  transform_hash(value, &block)
                elsif value.is_a?(Array)
                  value.map { |v| transform_hash(v, &block) }
                else
                  value
                end
        block.call(result, key, value)
        result
      end
    end

    def self.deep_stringify_keys(origin)
      transform_hash(origin) do |hash, key, value|
        hash[key.to_s] = value
      end
    end
  end
end