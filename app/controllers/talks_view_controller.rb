class TalksViewController < UIViewController
  attr_accessor :filter
  attr_accessor :dataSource

  def tableView(tv, numberOfRowsInSection:section)
    self.dataSource.count
  end


  def tableView(tv, cellForRowAtIndexPath:indexPath)
    @reuseIdentifier ||= 'TalkCell'

    cell = tv.dequeueReusableCellWithIdentifier(@reuseIdentifier) || begin
    TalkViewCell.alloc.initWithStyle(UITableViewCellStyleDefault, reuseIdentifier:@reuseIdentifier)
    end

    talk = self.dataSource[indexPath.row]
    cell.setupTalk(talk)

    cell
  end

  def tableView(tv, heightForRowAtIndexPath:indexPath)
    115 # fixed size
  end

  def viewDidLoad
    day, title = case filter
          when 'DayOne' then [1, 'Day One']
          when 'DayTwo' then [2, 'Day Two']
          when 'DayThree' then [3, 'Day Three']
          end

    self.title = title
    self.dataSource = Talk.talksByDay(day)
  end
end
