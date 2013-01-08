module ModelSupport

  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    def createWithHash(attributes)
      localContext = NSManagedObjectContext.MR_contextForCurrentThread

      model = buildWithHash(attributes)
      localContext.MR_save

      model
    end

    def buildWithHash(attributes)
      localContext = NSManagedObjectContext.MR_contextForCurrentThread
      klass = self.name

      model = klass.constantize.MR_createInContext(localContext)
      model.setValuesForKeysWithDictionary(attributes)

      idAttribute = "#{klass.underscore.camelize(:lower)}Id"
      id = attributes[idAttribute.to_sym] || 0
      if id == 0
        maxId = klass.constantize.MR_aggregateOperation('max', onAttribute: idAttribute, withPredicate: nil, inContext: localContext)
        model.send("#{idAttribute}=", maxId + 1)
      end

      model
    end
  end

  def save
    localContext = NSManagedObjectContext.MR_contextForCurrentThread
    localContext.MR_save
  end

  def inspect
    properties = []
    entity.properties.select { |p| p.is_a?(NSAttributeDescription) }.each do |property|
      properties << "#{property.name}: #{valueForKey(property.name).inspect}"
     end

     "#<#{entity.name} #{properties.join(", ")}>"
  end
end
