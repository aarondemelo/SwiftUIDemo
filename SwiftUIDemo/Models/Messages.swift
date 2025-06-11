import Foundation

struct Message: Identifiable, Codable, Hashable {
  let id = UUID()
  let avatar: URL
  let name: String
  let message: String
}
