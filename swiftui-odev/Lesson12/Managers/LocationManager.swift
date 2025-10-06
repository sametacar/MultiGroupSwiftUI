import CoreLocation

class LocationManager: NSObject, ObservableObject {
    private let manager = CLLocationManager()
    private let geocoder = CLGeocoder()
    
    @Published var userLocation: CLLocationCoordinate2D?
    @Published var authorizationStatus: CLAuthorizationStatus = .notDetermined
    @Published var userAddress: String = ""
    
    override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func requestPermission() {
        manager.requestWhenInUseAuthorization()
    }
    
    func startUpdating() {
        manager.startUpdatingLocation()
    }
    
    func stopUpdating() {
        manager.stopUpdatingLocation()
    }
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        
        DispatchQueue.main.async {
            self.userLocation = location.coordinate
        }
        
        // Adres çözümleme
        geocoder.reverseGeocodeLocation(locations.last!) { [weak self] placemarks, error in
            guard let placemark = placemarks?.first, error == nil else { return }
            var address = ""
            if let name = placemark.name { address += name + ", " }
            if let city = placemark.locality { address += city + ", " }
            if let country = placemark.country { address += country }
            DispatchQueue.main.async {
                self?.userAddress = address
            }
        }
    }
    
    // authorization değişti mi değişmedi mi
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        if manager.authorizationStatus == .authorizedWhenInUse {
            self.startUpdating()
        }
    }
    
    /// Fail olduğu durumlar için
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        print("Konum hatası: \(error.localizedDescription)")
    }
}
