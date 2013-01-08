class TalksViewController < UIViewController
  attr_accessor :filter
  attr_accessor :dataSource

  def tableView(tv, numberOfRowsInSection:section)
    self.dataSource.count
  end


  def tableView(tv, cellForRowAtIndexPath:indexPath)
    @reuseIdentifier ||= 'TalkCell'

    cell = tv.dequeueReusableCellWithIdentifier(@reuseIdentifier) || begin
    TalkCell.alloc.initWithStyle(UITableViewCellStyleDefault, reuseIdentifier:@reuseIdentifier)
    end

    team = self.dataSource[indexPath.row]
    #cell.pointsImage.image = UIImage.imageNamed('points.png')
    #cell.team_name.text = team.name
    #cell.city_info.text = team.city
    #cell.points.text = team.points.to_s
    #cell.logo.image = UIImage.imageNamed('guadalajara-mini.png')

    cell
  end

  def tableView(tv, heightForRowAtIndexPath:indexPath)
    115 # fixed size
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
