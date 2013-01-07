class TalksViewController < UIViewController
  attr_accessor :filter
  attr_accessor :dataSource

  def tableView(tv, numberOfRowsInSection:section)
    self.dataSource.count
  end

  def viewDidLoad
    day = case filter
          when 'DayOne' then 1
          when 'DayTwo' then 2
          when 'DayThree' then 3
          end

    self.dataSource = Talk.talksByDay(day)
  end
end
