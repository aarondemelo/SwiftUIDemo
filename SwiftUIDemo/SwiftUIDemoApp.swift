import AppRouter
import SwiftUI

typealias AppRouter = Router<AppTab, Destination, Sheet>

@main
struct SwiftUIDemoApp: App {

  @State var appState: AppState = .unauthenticated
  @State private var catalogueClient = CatalogueClient()
  @StateObject private var themeManager = ThemeManager()
  @Environment(\.colorScheme) private var systemColorScheme

  var body: some Scene {
    WindowGroup {
      switch appState {
      case .authenticated(let currentUser):
        HomeView()
          .background(themeManager.current.background)
      case .unauthenticated:
        LoginView { user in
          appState = .authenticated(currentUser: user)
        }
        .background(themeManager.current.background)
      }
    }.environment(\.appState, $appState)
      .environment(catalogueClient)
      .environmentObject(themeManager)
  }
}
