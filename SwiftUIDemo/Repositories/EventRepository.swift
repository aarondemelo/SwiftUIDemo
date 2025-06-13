import Foundation
import SwiftUI

protocol EventRepositoryProtocol {

  var filteredEvents: [Event] { get set }
  var filterSettings: EventFilterSettings { get set }

  func applyFilters()

  func loadEventsThrows() async throws
}

@Observable
class EventRepository: EventRepositoryProtocol {
  var allEvents: [Event] = []
  var filteredEvents: [Event] = []
  var filterSettings: EventFilterSettings

  private var catalogueClient: CatalogueClient

  private var observationTask: Task<Void, Never>?

  init(
    filterSettings: EventFilterSettings = EventFilterSettings(), catalogueClient: CatalogueClient
  ) {
    self.filterSettings = filterSettings
    self.catalogueClient = catalogueClient
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
      let price = Double(event.price)
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

  func loadEventsThrows() async throws {

    observationTask?.cancel()
    filterSettings.resetFilters()  // Reset filters via the settings object

    let loaded: [Event] = try await catalogueClient.loadEventsThrows()
    self.allEvents = loaded
    self.applyFilters()

    let allCities: Set<String> = loaded.reduce(into: Set<String>()) { result, event in
      result.formUnion(event.neighbourhoods)
    }

    let prices = loaded.map(\.price)
    let minPrice = prices.min() ?? 0
    let maxPrice = prices.max() ?? 0

    filterSettings.availableNeighbourhoods = Array(allCities).sorted()
    filterSettings.priceRange = Double(minPrice)...Double(maxPrice)
    filterSettings.selectedRange = Double(minPrice)...Double(maxPrice)

    observeFilterChanges()

  }

}
