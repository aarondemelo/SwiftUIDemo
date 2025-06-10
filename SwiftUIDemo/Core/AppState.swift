import Foundation
import SwiftUI

enum AppState: Sendable {
  case authenticated(currentUser: User)
  case unauthenticated

  var currentUser: User? {
    if case .authenticated(let currentUser) = self {
      return currentUser
    }
    return nil
  }
}

private struct AppStateKey: EnvironmentKey {
  static let defaultValue: Binding<AppState> = .constant(.unauthenticated)
}

extension EnvironmentValues {
  var appState: Binding<AppState> {
    get { self[AppStateKey.self] }
    set { self[AppStateKey.self] = newValue }
  }
}
