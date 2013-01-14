class PresenterViewCell < UITableViewCell
  extend IB

  outlet :picture, UIImageView
  outlet :name, UILabel
  outlet :twitter, UILabel

  def setupPresenter(presenter)
    self.name.text = presenter.name
    self.picture.image = UIImage.imageNamed(presenter.picture)
    self.twitter.text = presenter.twitter
  end
end
