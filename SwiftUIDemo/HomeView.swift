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
      case .openContacts:
          ContactsView()
      }
    }
    .environment(router)
    .environmentObject(filterSettings)
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
      EventsView().navigationDestination(for: Event.self) { event in
        EventDetailView(event: event)
      }
    case .messages:
      MessagesView().navigationDestination(for: Message.self) { message in
        ComposeMessageView(message: message)
      }
    case .profile: ProfileView()
    }
  }
}

#Preview {
  HomeView()
}
