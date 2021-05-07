//
//  ViewController.swift
//  Zuber
//
//  Created by Oguz Demırhan on 2.05.2021.
//

import UIKit
import MapKit
import CoreLocation
import FloatingPanel

class ViewController: UIViewController, SearchViewControllerDelegate,FloatingPanelControllerDelegate{
    
    //MARK: - delegateMethod
    func didSelectNewCoordinates(coordinates: CLLocationCoordinate2D?,title: String?) {
        
        print("delegate")
        guard let coordinates = coordinates else {
            return
        }
        
        mapView.removeAnnotations(mapView.annotations)
        
        let pin = MKPointAnnotation()
        pin.coordinate = coordinates
        mapView.addAnnotation(pin)
        mapView.setRegion(MKCoordinateRegion(center: coordinates, span: MKCoordinateSpan(latitudeDelta: 0.7, longitudeDelta: 0.7)), animated: true)
        
    
    
    }
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var locationButton: UIButton!
    @IBOutlet weak var listButton: UIButton!
    
    let userDefault = UserDefaults.standard
    let locationManager = CLLocationManager()
    var fpc: FloatingPanelController!
    
    
    //MARK:- viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    //MARK: -configure
    
    func configure() {
       
        checkLocationServices()
        fpc = FloatingPanelController()
        fpc.layout = MyFloatingPanelLayout()
        fpc.delegate = self
        guard let contentVC = storyboard?.instantiateViewController(identifier: "searchVC") as? SearchViewController else {return}
        contentVC.delegate = self
        fpc.set(contentViewController: contentVC)
        fpc.addPanel(toParent: self)
        listButton.layer.cornerRadius = locationButton.layer.bounds.width / 2
        listButton.layer.shadowColor = UIColor.gray.cgColor
        listButton.layer.shadowOffset = CGSize(width: 1, height: 1)
        listButton.layer.shadowRadius = 2.7
        listButton.layer.shadowOpacity = 0.6
        locationButton.layer.cornerRadius = locationButton.layer.bounds.width / 2
        locationButton.layer.shadowColor = UIColor.gray.cgColor
        locationButton.layer.shadowOffset = CGSize(width: 1, height: 1)
        locationButton.layer.shadowRadius = 2.7
        locationButton.layer.shadowOpacity = 0.6
        mapView.delegate = self
        mapView.translatesAutoresizingMaskIntoConstraints = false
        let dummyTitle = ["title"]
        let dummyAddress = ["address"]
        userDefault.setValue(dummyTitle, forKey: "titleArray")
        userDefault.setValue(dummyAddress, forKey: "addressArray")
    }
    
    
    @IBAction func locationButtonTapped(_ sender: Any) {
        showUserLocationCenterMap()
    }
    
    @IBAction func listButtonTapped(_ sender: UIButton) {
        
        guard let listVC = storyboard?.instantiateViewController(identifier: "addressListVC") as? AddressListViewController else {return}
        present(listVC, animated: true, completion: nil)
    }
    
    func checkLocationServices() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            checkLocationAuth()
        } else {
            
            showAccessAlert()
            
        }
    }
    
    func checkLocationAuth() {
   
        
        switch locationManager.authorizationStatus {
        case .restricted, .denied:
            showAccessAlert()
        case .authorizedWhenInUse:
            listenLocation()
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        default:
            showAccessAlert()
        }
    }
    func showAccessAlert() {
        
        let alertController = UIAlertController (title: "Error", message: "To the best experience you have to go to settings and open location services.", preferredStyle: .alert)

          let settingsAction = UIAlertAction(title: "Settings", style: .default) { (_) -> Void in

              guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                  return
              }

              if UIApplication.shared.canOpenURL(settingsUrl) {
                  UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                      print("Settings opened: \(success)")
                  })
              }
          }
          alertController.addAction(settingsAction)
          let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
          alertController.addAction(cancelAction)
        DispatchQueue.main.async {
            self.present(alertController, animated: true, completion: nil)
        }
          
    }
    
    func listenLocation() {
        showUserLocationCenterMap()
        locationManager.startUpdatingLocation()
    }

    
    
    func showUserLocationCenterMap() {
        print("wololo")
         if let location = locationManager.location?.coordinate {
             let region = MKCoordinateRegion.init(center: location, latitudinalMeters: 1000, longitudinalMeters: 1000)
             let pin = MKPointAnnotation()
             pin.coordinate = location
             mapView.addAnnotation(pin)
             mapView.setRegion(region, animated: true)
         }
     }
    
    
    //MARK: - drawDirection
//    func drawDirection(coordinateOne: CLLocationCoordinate2D, coordinateTwo: CLLocationCoordinate2D) {
//
//        mapView.removeOverlays(mapView.overlays)
//
//        let request = MKDirections.Request()
//        request.source = MKMapItem(placemark: MKPlacemark(coordinate: coordinateOne))
//        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: coordinateTwo))
//        request.requestsAlternateRoutes = true
//        request.transportType = .automobile
//
//        let directions = MKDirections(request: request)
//        directions.calculate { [unowned self] response, error in
//                    guard let unwrappedResponse = response else { return }
//                    if let route = unwrappedResponse.routes.first {
//                        self.mapView.addOverlay(route.polyline)
//                        self.mapView.setVisibleMapRect(route.polyline.boundingMapRect, edgePadding: UIEdgeInsets.init(top: 80.0, left: 20.0, bottom: 100.0, right: 20.0), animated: true)
//                    }
//                }
//    }
}


//MARK: - Location and MKMapView Delegates
extension ViewController : CLLocationManagerDelegate, MKMapViewDelegate {
     
    
//    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
//       let renderer = MKPolylineRenderer(overlay: overlay)
//        renderer.strokeColor = UIColor.blue
//        renderer.lineWidth = 5.0
//        return renderer
//    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        }
        

        let reuseId = "pin"
        var pav: MKPinAnnotationView? = self.mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
        if pav == nil {
            pav = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pav?.isDraggable = true
            pav?.canShowCallout = true
        } else {
            pav?.annotation = annotation
        }

        return pav
    }
    
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, didChange newState: MKAnnotationView.DragState, fromOldState oldState: MKAnnotationView.DragState)
        {
        if (newState == MKAnnotationView.DragState.ending)
            {
                let geocoder = CLGeocoder()
                guard let droppedAt = view.annotation?.coordinate else {return}
                let adressLocation = CLLocation(latitude: droppedAt.latitude, longitude: droppedAt.longitude)
            geocoder.reverseGeocodeLocation(adressLocation) { placemark, err in
                
                guard let placemark = placemark else {return}
                guard let addressVC = self.storyboard?.instantiateViewController(identifier: "addressVC") as? AddressViewController else {return}
                guard let locality = placemark[0].locality else {return}
                guard let subLocality = placemark[0].subLocality else {return}
                guard let subAdminisrativeArea = placemark[0].subAdministrativeArea else {return}
                guard let postalCode = placemark[0].postalCode else {return}
                
                
                
                addressVC.addressText = locality + "," + subLocality + "," + subAdminisrativeArea + "," + postalCode
                self.present(addressVC, animated: true, completion: nil)
            }

                view.setDragState(.none, animated: true)
            }
            if (newState == .canceling )
            {
                view.setDragState(.none, animated: true)
            }
        }
    
    
    

}

//MARK: -FloatingPanelLayout

class MyFloatingPanelLayout: FloatingPanelLayout {
    let position: FloatingPanelPosition = .bottom
    let initialState: FloatingPanelState = .tip
    var anchors: [FloatingPanelState: FloatingPanelLayoutAnchoring] {
        return [
            .full: FloatingPanelLayoutAnchor(absoluteInset: 16.0, edge: .top, referenceGuide: .safeArea),
            .half: FloatingPanelLayoutAnchor(fractionalInset: 0.5, edge: .bottom, referenceGuide: .safeArea),
            .tip: FloatingPanelLayoutAnchor(absoluteInset: 25, edge: .bottom, referenceGuide: .safeArea),
        ]
    }
}

