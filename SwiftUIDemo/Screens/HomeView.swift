import AppRouter
import SwiftUI

struct HomeView: View {
  @State private var router = AppRouter(initialTab: .events)
  @Environment(EventRepository.self) private var eventRepository
  @EnvironmentObject var themeManager: ThemeManager

  var body: some View {
    TabView(selection: $router.selectedTab) {
      ForEach(AppTab.allCases, id: \.self) { tab in
        NavigationStack(path: $router[tab]) {
          viewForTab(tab).navigationDestination(for: Destination.self) { destination in
            destinationView(for: destination)
          }
        }
        .tabItem {
          Label(tab.rawValue.capitalized, image: tab.icon)
        }
        .tag(tab)
      }
    }.sheet(item: $router.presentedSheet) { presentedSheet in
      Group {
        switch presentedSheet {
        case .eventFilters:
          EventsFilterView(filterSettings: eventRepository.filterSettings)
        case .openContacts:
          ContactsView()
        }
      }.presentationBackground(themeManager.current.background)

    }
    .environment(router)
  }

  @ViewBuilder
  private func destinationView(for destination: Destination) -> some View {
    switch destination {
    case .eventDetail(let event):
      EventDetailView(event: event)
    case .openMessage(let message):
      ComposeMessageView(message: message)
    default:
      EmptyView()
    }
  }

  @ViewBuilder
  func viewForTab(_ tab: AppTab) -> some View {
    switch tab {
    case .events:
      EventsView()
    case .messages:
      MessagesView()
    case .profile: ProfileView()
    }
  }
}

struct HomeView_Previews: PreviewProvider {
  static let themeManager = ThemeManager()
  static let myRouterObject = AppRouter(initialTab: AppTab.events)
  static let catalogueClient = CatalogueClient()

  static var previews: some View {
    HomeView()
      .environment(myRouterObject)
      .environmentObject(themeManager)
      .environment(catalogueClient)

  }
}
