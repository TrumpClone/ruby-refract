class Refract
  def self.search(json, query)
    fail(ArgumentError, 'Expected hash as the first argument') unless json.is_a?(Hash)
    fail(ArgumentError, 'Expected hash as the second argument') unless query.is_a?(Hash)

    recursive_lookup(json.stringify_keys, query.stringify_keys)
  end

  private

  def self.recursive_lookup(json, query)
    return [] unless json['content']
    return [] unless json['content'].is_a?(Array)

    result = json['content'].select do |element|
      query.map do |k, v|
        if v.is_a?(Hash) && element[k].is_a?(Hash)
          (v.to_a - element[k].to_a).empty?
        else
          element[k] == v
        end
      end.all?
    end

    json['content'].map do |element|
      search(element, query)
    end.flatten.concat(result)
  end
end