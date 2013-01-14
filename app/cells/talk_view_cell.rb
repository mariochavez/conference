class TalkViewCell < UITableViewCell
  extend IB

  outlet :talk, UILabel
  outlet :speaker, UILabel
  outlet :day, UILabel
  outlet :picture, UIImageView

  def setupTalk(talk)
    self.talk.text = talk.title
    self.speaker.text = talk.presenter.name
    self.picture.image = UIImage.imageNamed(talk.presenter.picture)
    self.day.text = "Day #{talk.day}, #{talk.time}"
  end
end
