import AppRouter
import SwiftUI

struct HomeView: View {
  @State private var router = AppRouter(initialTab: .events)
  @StateObject private var filterSettings = EventFilterSettings()

  var body: some View {
    TabView(selection: $router.selectedTab) {
      ForEach(AppTab.allCases, id: \.self) { tab in
        NavigationStack {
          viewForTab(tab)
        }
        .tabItem {
          Label(tab.rawValue.capitalized, image: tab.icon)
        }
        .tag(tab)
      }
    }
    .sheet(item: $router.presentedSheet) { presentedSheet in
      switch presentedSheet {
      case .eventFilters:
        EventsFilterView()
      case .composeMessage:
        ComposeMessagesView()
      }
    }
    .environment(router)
    .environmentObject(filterSettings)
  }

  @ViewBuilder
  func viewForTab(_ tab: AppTab) -> some View {
    switch tab {
    case .events:
      EventsView().navigationDestination(for: Event.self) { event in
        EventDetailView(event: event)
      }
    case .messages: MessagesView()
    case .profile: ProfileView()
    }
  }
}

#Preview {
  HomeView()
}
