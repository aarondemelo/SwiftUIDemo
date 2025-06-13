import Foundation

protocol CatalogueClientProtocol {

  func loadEventsThrows() async throws -> [Event]

  func loadMessagesThrows() async throws -> [Message]
}

@Observable
class CatalogueClient: CatalogueClientProtocol {

  private let decoder: JSONDecoder

  init() {
    decoder = JSONDecoder()
    decoder.dateDecodingStrategy = .iso8601
  }

  func loadEventsThrows() async throws -> [Event] {
    return try await loadJSONThrows(from: "EventsResponse")
  }

  func loadMessagesThrows() async throws -> [Message] {
    return try await loadJSONThrows(from: "MessagesResponse")
  }

  private func loadJSONThrows<T: Decodable>(from path: String) async throws -> [T] {
    return try await withCheckedThrowingContinuation { continuation in
      Task {
        guard let url = Bundle.main.url(forResource: path, withExtension: "json") else {
          let error = NSError(
            domain: "CatalogueClient", code: 404,
            userInfo: [NSLocalizedDescriptionKey: "File not found: \(path)"])
          continuation.resume(throwing: error)
          return
        }

        do {
          let data = try Data(contentsOf: url)
          let result = try decoder.decode([T].self, from: data)
          continuation.resume(returning: result)
        } catch {
          continuation.resume(throwing: error)
        }
      }
    }
  }
}
