import AppRouter
import SwiftUI

enum AppTab: String, TabType, CaseIterable {
  case events, messages, profile

  var id: String { rawValue }

  var icon: String {
    switch self {
    case .events: return "Map"
    case .messages: return "Mail"
    case .profile: return "Person"
    }
  }
}

enum Destination: DestinationType {
  case eventDetail(event: Event)
  case openMessage(message: Message?)
  case profile(userId: String)

  static func from(path: String, fullPath: [String], parameters: [String: String]) -> Destination? {
    nil
  }
}

enum Sheet: SheetType {
  case eventFilters
  case openContacts

  var id: Int { hashValue }
}
