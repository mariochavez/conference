class VenueViewController < UIViewController
  extend IB

  outlet :mapView, MKMapView

  def viewDidAppear(animated)
    super(animated)

    setMapLocation
  end

  def setMapLocation
    location = CLLocationCoordinate2DMake(19.116584, -104.393291)

    annotation = Annotation.alloc.initWithCoordinates(location, title:'MagmaConf', subTitle:'Manzanillo, Mexico')

    region = MKCoordinateRegionMake(location, MKCoordinateSpanMake(0.5, 0.5))

    mapView.addAnnotation(annotation)
    mapView.setRegion(region, animated:false)
  end
end

