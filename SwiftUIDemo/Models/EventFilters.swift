import Foundation
import SwiftUI

@Observable
class EventFilterSettings {
  var selectedNeighbourhoods: Set<String> = []
  var priceRange: ClosedRange<Int> = 0...150
  var selectedRange: ClosedRange<Float> = 20...80
  var eventTimeOfDay: Set<TimeOfDay> = []
  var sortOrder: SortOrder = .newestFirst

  var availableNeighbourhoods: [String] = [
    "Chelsea", "Harlem", "Tribeca", "Red Hook", "Flushing", "Upper East Side", "Forest Hills",
    "Williamsburg", "Astoria", "Greenwich Village", "Upper West Side", "Soho", "Brooklyn Heights",
    "Battery Park City", "East Village", "Bushwick", "Long Island City", "DUMBO",
  ]

  func resetFilters() {
    selectedNeighbourhoods = []
    selectedRange = Float(priceRange.lowerBound)...Float(priceRange.upperBound)  // Reset to full default price range
    eventTimeOfDay = []
    sortOrder = .newestFirst
  }
}

enum TimeOfDay {
  case day
  case night
}

enum SortOrder: String, CaseIterable, Identifiable {
  case newestFirst = "Newest First"
  case oldestFirst = "Oldest First"
  case highestPriceFirst = "Highest Price First"
  case lowestPriceFirst = "Lowest Price First"

  var id: String { self.rawValue }
}

extension Event {
  var timeOfDay: TimeOfDay {
    let calendar = Calendar.current
    let hour = calendar.component(.hour, from: dateTime)
    return hour >= 19 ? .night : .day
  }
}
