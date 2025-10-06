import SwiftUI
import CoreLocation
import SwiftData

struct PointSheetView: View {
    let coordinate: CLLocationCoordinate2D
    let onCancel: () -> Void

    // SwiftData model context
    @Environment(\.modelContext) private var context
    @State private var name: String = ""

    var body: some View {
        VStack(spacing: 16) {
            Capsule()
                .frame(width: 40, height: 5)
                .foregroundColor(.gray.opacity(0.4))
                .padding(.top, 8)

            Text("Yeni Nokta Ekle")
                .font(.headline)

            Text(String(format: "Lat: %.5f, Lon: %.5f", coordinate.latitude, coordinate.longitude))
                .font(.subheadline)
                .foregroundColor(.secondary)

            TextField("Nokta ismi girin...", text: $name)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)

            HStack {
                Button("Vazgeç") {
                    onCancel()
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)

                Button("Ekle") {
                    savePoint()
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(name.isEmpty ? Color.gray : Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
                .disabled(name.isEmpty)
            }
            .padding(.horizontal)

            Spacer()
        }
    }

    private func savePoint() {
        let newPoint = Point(
                name: name,
                latitude: coordinate.latitude,
                longitude: coordinate.longitude
            )
            context.insert(newPoint)
            do {
                try context.save()
                onCancel() // Sheet kapat
            } catch {
                print("SwiftData save hatası: \(error.localizedDescription)")
            }
    }
}

#Preview {
    PointSheetView(
        coordinate: CLLocationCoordinate2D(latitude: 40.9187, longitude: 29.1604),
        onCancel: { }
    )
    .modelContainer(for: Point.self) // Preview'da SwiftData için gerekli
}

