import Foundation
import SwiftUI

@Observable
class CatalogueClient {

  var allEvents: [Event] = []  // Stores the unfiltered, raw events
  var filteredEvents: [Event] = []  // Stores the events after applying filters

  var filterSettings: EventFilterSettings  // Not @Published if @Observable

  private let decoder: JSONDecoder
  private var observationTask: Task<Void, Never>?

  init(filterSettings: EventFilterSettings = EventFilterSettings()) {
    decoder = JSONDecoder()
    decoder.dateDecodingStrategy = .iso8601
    self.filterSettings = filterSettings
    observeFilterChanges()

  }

  private func observeFilterChanges() {
    // Cancel any existing observation task before starting a new one
    observationTask?.cancel()

    // Use withObservationTracking to observe changes in filterSettings
    // This closure will be rerun whenever an observed property of filterSettings changes
    observationTask = Task {
      withObservationTracking {
        // Access all properties of filterSettings that you want to observe
        // Any property accessed here will be "tracked"
        _ = filterSettings.selectedNeighbourhoods
        _ = filterSettings.priceRange
        _ = filterSettings.selectedRange
        _ = filterSettings.eventTimeOfDay
        _ = filterSettings.sortOrder
      } onChange: {
        // This block is called when any of the tracked properties change
        Task { @MainActor in  // Ensure UI updates happen on the main actor
          print("CatalogueClient: Filter settings changed. Re-applying filters.")
          self.applyFilters()
        }
      }
    }
  }

  func applyFilters() {
    print("Applying filters...")
    var tempEvents = allEvents

    if !filterSettings.selectedNeighbourhoods.isEmpty {
      tempEvents = tempEvents.filter { event in
        !Set(event.neighbourhoods).isDisjoint(with: filterSettings.selectedNeighbourhoods)
      }
    }

    tempEvents = tempEvents.filter { event in
      filterSettings.eventTimeOfDay.isEmpty
        || filterSettings.eventTimeOfDay.contains(event.timeOfDay)
    }

    tempEvents = tempEvents.filter { event in
      let price = Float(event.price)
      return price >= filterSettings.selectedRange.lowerBound
        && price <= filterSettings.selectedRange.upperBound
    }

    tempEvents = tempEvents.sorted { lhs, rhs in
      switch filterSettings.sortOrder {
      case .newestFirst:
        return lhs.dateTime > rhs.dateTime
      case .oldestFirst:
        return lhs.dateTime < rhs.dateTime
      case .highestPriceFirst:
        return lhs.price > rhs.price
      case .lowestPriceFirst:
        return lhs.price < rhs.price
      }
    }

    self.filteredEvents = tempEvents
    observeFilterChanges()
    print("Filters applied. Filtered events count: \(self.filteredEvents.count)")
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

    observationTask?.cancel()  // Stop observing during this process

    filterSettings.resetFilters()  // Reset filters via the settings object

    let loaded: [Event] = try await loadJSONThrows(from: "EventsResponse")
    self.allEvents = loaded
    self.applyFilters()  // Apply filters immediately after loading

    // Restart observation after changes are complete
    observeFilterChanges()

    return self.filteredEvents

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
