class Refract
  def self.search(json, query)
    fail(ArgumentError, 'Expected hash as the first argument') unless json.is_a?(Hash)
    fail(ArgumentError, 'Expected hash as the second argument') unless query.is_a?(Hash)

    return [] unless json['content']
    return [] unless json['content'].is_a?(Array)

    result = json['content'].select do |element|
      query.map do |k, v|
        # TODO: deep search
        element[k] == v
      end.all?
    end

    json['content'].map do |element|
      search(element, query)
    end.flatten.concat(result)
  end
end