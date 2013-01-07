class Talk < NSManagedObject
  include ModelSupport

  class << self
    def allTalks
      Talk.MR_findAllSortedBy('time', ascending:true)
    end

    def talksByDay(day)
      Talk.MR_findByAttribute('day', withValue:day, andOrderBy:'time', ascending: true)
    end
  end
end
