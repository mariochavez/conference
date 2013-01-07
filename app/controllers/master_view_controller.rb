class MasterViewController < UITableViewController

  def prepareForSegue(segue, sender: sender)
    case segue.identifier
    when 'DayOne', 'DayTwo', 'DayThree'
      segue.destinationViewController.setFilter segue.identifier
    end
  end

end
