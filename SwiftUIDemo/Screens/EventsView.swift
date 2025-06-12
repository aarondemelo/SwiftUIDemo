import SwiftUI

struct EventsView: View {
  @Environment(CatalogueClient.self) private var catalogueClient
  @Environment(AppRouter.self) private var router

  @State private var isLoading = false
  @State private var errorMessage: String?

  var body: some View {
    VStack {
      if let errorMessage = errorMessage {
        ErrorView(message: errorMessage) {
          Task { await loadEvents() }
        }
      } else if isLoading {
        ProgressView("Loading events...")
          .frame(maxWidth: .infinity, maxHeight: .infinity)
      } else {
        List {
          ForEach(catalogueClient.filteredEvents, id: \.id) { event in
            // *** Wrap EventRowView in NavigationLink ***
            ZStack(alignment: .leading) {
              EventRowView(event: event)
              NavigationLink(value: Destination.eventDetail(event: event)) {
                EmptyView()
              }.opacity(0)
            }.listRowInsets(EdgeInsets(top: 8, leading: 6, bottom: 8, trailing: 6))

              .listRowSeparator(.hidden)

          }
        }.listStyle(.plain)
          .padding(8)
      }
    }
    .navigationTitle("Events")
    .toolbar {
      ToolbarItem(placement: .topBarTrailing) {
        ToolbarButton(iconName: "Filter") {
          router.presentSheet(.eventFilters)
        }
      }
    }
    .task {
      await loadEvents()
    }
    .refreshable {
      await loadEvents()
    }.scrollContentBackground(.hidden)
    //}
  }

  private func loadEvents() async {
    isLoading = true
    errorMessage = nil

    do {
      try await catalogueClient.loadEventsThrows()
    } catch {
      errorMessage = error.localizedDescription
    }

    isLoading = false
  }

}

struct EventsView_Previews: PreviewProvider {
  static let myEnvObject = CatalogueClient()
  static let myRouterObject = AppRouter(initialTab: AppTab.events)
  static var previews: some View {
    EventsView()
      .environment(myRouterObject)
      .environment(myEnvObject)
  }
}
