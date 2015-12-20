module Versioned

end

module ViewStatistics

end

class Web10xModel
  extend SoftDeleteable
  extend Versioned

  def self.define_attributes
    yield AttributesBuilder.new(self)
  end

  def self.relations
    @relations ||= []
  end

  def self.attributes
    @attributes ||= []
  end

  def self.belongs_to(target)
    relations << target
  end
end


class AttributesBuilder
  def initialize(owner)
    @owner = owner
  end

  def attribute(name, type)
    @owner.attributes << [name, type]
  end
end
