//
//  MapVC.swift
//  MEdiaFinder 2
//
//  Created by nassermac on 5/5/23.
//  Copyright © 2023 Nasser Co. All rights reserved.
//

import MapKit

class MapVC: UIViewController {

    //MARK: - outlets
    
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    
    //MARK: - Propierties
    weak var delegate: AddressDelegation?
    private var locationManager = CLLocationManager()
    //MARK: - lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.mapType = .hybridFlyover
        checkLocationServises()
        mapView.delegate = self
        // testing
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false

    }
    
    //MARK: - Actions
    @IBAction func confirmBtnTapped(_ sender: UIButton) {
        delegate?.sentAddress(address: addressLabel.text ?? "")
        self.navigationController?.popViewController(animated: true)
    }
    
}

    //MARK: - Actions
extension MapVC: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        let lat = mapView.centerCoordinate.latitude
        let long = mapView.centerCoordinate.longitude
        let location = CLLocation(latitude: lat, longitude: long)
        getAddressLocation(location: location)
    }
    
    private func getAddressLocation(location: CLLocation){
     let geoCoder :CLGeocoder = CLGeocoder()
        geoCoder.reverseGeocodeLocation(location) { (placeMarks, error) in
            if let error = error {
                print(error.localizedDescription)
            }
            else if let firstPlaceMark = placeMarks?.first {
        self.addressLabel.text = firstPlaceMark.compactAddress ?? "Not Found"
            }
        }
    }
    private func checkLocationServises(){
        if CLLocationManager.locationServicesEnabled(){
            
        }else{
            print("Please, Open Location Services")
        }
    }
//TODO: FOR Testing Static Location
    private func testLocation(){
        let location :CLLocation = CLLocation(latitude: 30.096655, longitude: 31.662533)
        let reigon = MKCoordinateRegion(center: location.coordinate, latitudinalMeters:9000, longitudinalMeters: 9000)
        mapView.setRegion(reigon, animated: true)
        getAddressLocation(location: location)
    }
    private func currentLocation(){
        if let location = locationManager.location?.coordinate{
            let reigon = MKCoordinateRegion(center: location, latitudinalMeters:9000, longitudinalMeters: 9000)
            mapView.setRegion(reigon, animated: true)
            getAddressLocation(location: locationManager.location!)
        }
    }
    
    private func checkLocationAutheraztion(){
        switch CLLocationManager.authorizationStatus(){
        case.authorizedAlways, .authorizedWhenInUse :
          currentLocation()
        case.restricted, .notDetermined :
            print("Can Not Get Your Location !! ")
        case.denied :
            locationManager.requestWhenInUseAuthorization()
        default :
            print("Can Not Get Your Location !! ")
        }
    }
    

    
    
    
    
    
    
    
    
    
    
    
}
