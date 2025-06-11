import Foundation
import SwiftUI

@Observable
class CatalogueClient {

  private let decoder: JSONDecoder

  init() {
    decoder = JSONDecoder()
    decoder.dateDecodingStrategy = .iso8601
  }

  func loadEvents() async -> [Event] {
    return await loadJSON(from: "Responses/events.json")
  }

  func loadComments() async -> [Message] {
    return await loadJSON(from: "Responses/comments.json")
  }

  func setFilters() {

  }

  private func loadJSON<T: Decodable>(from path: String) async -> [T] {
    return await withCheckedContinuation { continuation in
      Task {
        guard let url = Bundle.main.url(forResource: path, withExtension: nil) else {
          print("⚠️ File not found: \(path)")
          continuation.resume(returning: [])
          return
        }

        do {
          let data = try Data(contentsOf: url)
          let result = try decoder.decode([T].self, from: data)
          continuation.resume(returning: result)
        } catch {
          print("❌ Failed to decode \(path): \(error)")
          continuation.resume(returning: [])
        }
      }
    }
  }
}

extension CatalogueClient {

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
