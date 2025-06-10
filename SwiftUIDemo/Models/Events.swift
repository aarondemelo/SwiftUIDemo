import Foundation

struct Event: Identifiable, Codable, Hashable {  // < {
  let id = UUID()  // Or you can use a custom `id` from JSON if available
  let imageUrl: URL
  let title: String
  let author: String
  let neighbourhoods: [String]
  let dateTime: Date
  let description: String
  let price: Double
}
