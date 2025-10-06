import SwiftUI
import MapKit
import SwiftData
import CoreLocation


fileprivate struct IdentifiableCoordinate: Identifiable, Equatable {
    let id = UUID()
    let coordinate: CLLocationCoordinate2D
    
    // Equatable
    static func == (lhs: IdentifiableCoordinate, rhs: IdentifiableCoordinate) -> Bool {
        return lhs.coordinate.latitude == rhs.coordinate.latitude &&
               lhs.coordinate.longitude == rhs.coordinate.longitude
    }
}

struct MapView: View {
    // data
    @Environment(\.modelContext) private var context
    @Query(sort: \Point.name, order: .forward) private var points: [Point]
    
    @ObservedObject var locationManager: LocationManager
    // referans nokta
    @State private var cameraPosition: MapCameraPosition = .region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 40.9243276, longitude: 29.1654994), // Piazza civarı
            span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02) // Zoom seviyesi
        )
    )
    @State private var selectedPoint: Point?
    @State private var route: MKRoute?
    
    // Sheet kontrolü
    @State private var isAddingPoint = false
    @State private var tappedCoordinate: IdentifiableCoordinate?
    
    var body: some View {
        MapReader { proxy in
            mapLayer(proxy: proxy)
            
            // Canlı konum kutusu
            if let coordinate = locationManager.userLocation {
                VStack(alignment: .leading, spacing: 2) {
                    Text("Canlı Konum")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    Text(String(format: "Lat: %.5f, Lon: %.5f", coordinate.latitude, coordinate.longitude))
                        .font(.footnote)
                    if !locationManager.userAddress.isEmpty {
                        Text("Adres: \(locationManager.userAddress)")
                            .font(.footnote)
                            .lineLimit(1)
                    }
                }
                .padding(4)
                .background(Color.white.opacity(0.8))
                .cornerRadius(8)
                .shadow(radius: 2)
                .padding(.bottom, 10)
                .padding(.leading, 4)
            }
        }
        .onAppear {
            locationManager.requestPermission()
        }
    }
}

// MARK: - Map Layer
private extension MapView {
    @ViewBuilder
    func mapLayer(proxy: MapProxy) -> some View {
        ZStack {
            mapViewContent(proxy: proxy)
        }
    }
    
    @ViewBuilder
    func mapViewContent(proxy: MapProxy) -> some View {
        Map(position: $cameraPosition, selection: $selectedPoint) {
            UserAnnotation()
            
            ForEach(points) { point in
                Annotation(point.name, coordinate: point.coordinate) {
                    VStack(spacing: 1) {
                        Image(systemName: "mappin.circle.fill")
                            .padding(2)
                            .font(.largeTitle)
                            .foregroundColor(.red)
                            .background(Color.white)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.white, lineWidth: 2))
                    }
                }
                .tag(point)
            }
            
            if let route {
                MapPolyline(route)
                    .stroke(.blue, lineWidth: 5)
            }
        }
        .mapStyle(.imagery)
        .mapControls {
            MapUserLocationButton()
            MapCompass()
        }
        // Tap ile koordinat al
        .onTapGesture(coordinateSpace: .local) { location in
            if let coordinate = proxy.convert(location, from: .local) {
                tappedCoordinate = IdentifiableCoordinate(coordinate: coordinate)
            }
        }
        .onChange(of: selectedPoint) { _, newValue in
            if let point = newValue, let userLocation = locationManager.userLocation {
                fetchRoute(from: userLocation, to: point.coordinate)
            } else {
                route = nil
            }
        }
        /// point ekleme sheeti
        .sheet(item: $tappedCoordinate) { item in
            PointSheetView(coordinate: item.coordinate) {
                tappedCoordinate = nil
            }
        } //: sheet
    }
}

// MARK: - Helpers
private extension MapView {
    func addPoint(name: String, coordinate: CLLocationCoordinate2D) {
        let newPoint = Point(name: name, latitude: coordinate.latitude, longitude: coordinate.longitude)
        context.insert(newPoint)
        try? context.save()
    }
    
    func fetchRoute(from start: CLLocationCoordinate2D, to end: CLLocationCoordinate2D) {
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: MKPlacemark(coordinate: start))
        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: end))
        request.transportType = .walking
        
        let directions = MKDirections(request: request)
        directions.calculate { response, error in
            if let error {
                print("Rota hesaplama hatası: \(error.localizedDescription)")
                return
            }
            guard let route = response?.routes.first else { return }
            self.route = route
        }
    }
}



// MARK: - Preview
#Preview {
    MapView(locationManager: LocationManager())
        .modelContainer(for: Point.self)
}
