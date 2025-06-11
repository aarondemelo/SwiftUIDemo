import Foundation
import Combine

class EventFilterSettings: ObservableObject {
    @Published var selectedNeighbourhoods: Set<String> = []
    @Published var priceRange: ClosedRange<Int> = 0...150
    @Published var selectedRange: ClosedRange<Float> = 20...80
    @Published var eventTimeOfDay: Set<TimeOfDay> = []
    @Published var sortOrder: SortOrder = .newestFirst
    var availableNeighbourhoods: [String] = ["Chelsea", "Harlem", "Tribeca","Red Hook", "Flushing","Upper East Side", "Forest Hills", "Williamsburg", "Astoria", "Greenwich Village", "Upper West Side", "Soho", "Brooklyn Heights", "Battery Park City", "East Village", "Bushwick", "Long Island City", "DUMBO"]
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
