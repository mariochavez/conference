class PresentersViewController < UIViewController
  attr_accessor :dataSource

  def tableView(tv, numberOfRowsInSection:section)
    self.dataSource.count
  end

  def tableView(tv, cellForRowAtIndexPath:indexPath)
    @reuseIdentifier ||= 'PresenterCell'

    cell = tv.dequeueReusableCellWithIdentifier(@reuseIdentifier) || begin
    PresenterViewCell.alloc.initWithStyle(UITableViewCellStyleDefault, reuseIdentifier:@reuseIdentifier)
    end

    presenter = self.dataSource[indexPath.row]
    cell.setupPresenter(presenter)

    cell
  end

  def tableView(tv, heightForRowAtIndexPath:indexPath)
    100
  end

  def viewDidLoad
    self.dataSource = Presenter.MR_findAll
  end
end
