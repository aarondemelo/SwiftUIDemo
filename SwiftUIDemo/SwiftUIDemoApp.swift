import AppRouter
import SwiftUI

typealias AppRouter = Router<AppTab, Destination, Sheet>

@main
struct SwiftUIDemoApp: App {

  @State var appState: AppState = .unauthenticated
  @State private var catalogueClient = CatalogueClient()
  @Environment(\.colorScheme) private var colorScheme
  @StateObject private var themeManager: ThemeManager

  init() {
    // Use an initializer to create themeManager with the initial colorScheme
    // Note: At this point, colorScheme might still be .light in previews or very early app launch.
    // The .onChange and .onAppear (if you add it) will ensure it's correct.
    _themeManager = StateObject(wrappedValue: ThemeManager(colorScheme: .light))  // Placeholder, updated by onAppear/onChange
  }

  var body: some Scene {
    WindowGroup {
      Group {
        switch appState {
        case .authenticated(let currentUser):
          HomeView()
        case .unauthenticated:
          LoginView { user in
            appState = .authenticated(currentUser: user)
          }
        }
      }
      .background(themeManager.current.background)
      .onChange(of: colorScheme) { oldValue, newValue in
        print("New Color Scheme \(newValue) Old value \(oldValue)")
        // You can use 'newValue' directly here, or 'oldValue' if needed.
        themeManager.updateTheme(for: newValue)
      }
      .environment(\.appState, $appState)
      .environment(catalogueClient)
      .environmentObject(themeManager)
    }
  }
}
