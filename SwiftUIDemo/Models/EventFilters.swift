import Foundation
import Combine

class EventFilterSettings: ObservableObject {
    @Published var selectedNeighbourhoods: Set<String> = []
    @Published var priceRange: ClosedRange<Double> = 0...1000  // example range
    @Published var eventTimeOfDay: Set<TimeOfDay> = []
    @Published var sortOrder: SortOrder = .newestFirst
    var availableNeighbourhoods: [String] = []
    // This can be populated with actual neighbourhood data
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
