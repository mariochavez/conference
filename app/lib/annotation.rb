class Annotation

  def coordinate; @coordinate; end
  def title; @title; end
  def subtitle; @subtitle; end

  def initWithCoordinates(paramCoordinates, title:paramTitle, subTitle:paramSubTitle)
    @coordinate = paramCoordinates
    @title = paramTitle
    @subtitle = paramSubTitle

    self
  end
end
