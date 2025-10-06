import SwiftUI
import SwiftData
import CoreLocation

struct FavoritesView: View {
    @Environment(\.modelContext) private var context
    @Query(sort: \Point.name, order: .forward) private var points: [Point]

    @State private var pointsEditMode = false

    var body: some View {
        NavigationStack {
            List {
                if points.isEmpty {
                    VStack(spacing: 8) {
                        Image(systemName: "mappin.slash")
                            .font(.largeTitle)
                            .foregroundColor(.gray)
                        Text("Henüz kaydedilmiş nokta yok.")
                            .foregroundColor(.gray)
                            .font(.subheadline)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.top, 40)
                    .listRowSeparator(.hidden)
                } else {
                    ForEach(points) { point in
                        VStack(alignment: .leading, spacing: 4) {
                            Text(point.name)
                                .font(.headline)
                            Text(String(format: "Lat: %.4f, Lon: %.4f", point.latitude, point.longitude))
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                        .padding(.vertical, 6)
                        .swipeActions(edge: .trailing) {
                                Button(role: .destructive) {
                                    if let index = points.firstIndex(of: point) {
                                        deletePoints(at: IndexSet(integer: index))
                                    }
                                } label: {
                                    Text("Sil")
                                }
                            }
                        
                    }
                    .onDelete(perform: deletePoints)
                }
            }
            .navigationTitle("Noktalarım")
            .toolbar {
                Button(pointsEditMode ? "Bitti" : "Düzenle") {
                    pointsEditMode.toggle()
                }
            }
            .environment(\.editMode, .constant(pointsEditMode ? EditMode.active : EditMode.inactive))
        }
    }

    private func deletePoints(at offsets: IndexSet) {
        for index in offsets {
            context.delete(points[index])
        }
        try? context.save()
    }
}
