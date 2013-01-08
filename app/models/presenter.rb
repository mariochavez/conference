class Presenter < NSManagedObject
  include ModelSupport

  def addTalk(talk)
    self.addTalksObject(talk)
  end

  def myTalks
    _talks = []
    self.talks.each{|talk| _talks << talk} unless self.talks.nil?
    _talks
  end
end
