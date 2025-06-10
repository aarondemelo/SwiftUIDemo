import Foundation

struct Message: Identifiable, Codable {
  let id = UUID()
  let avatar: URL
  let name: String
  let message: String
}
