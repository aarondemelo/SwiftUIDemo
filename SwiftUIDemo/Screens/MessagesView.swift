import SwiftUI

struct MessagesView: View {
  @Environment(CatalogueClient.self) private var catalogueClient
  @Environment(AppRouter.self) private var router

  @State private var messages: [Message] = []
  @State private var isLoading = false
  @State private var errorMessage: String?

  var body: some View {
    VStack {
      if let errorMessage = errorMessage {
        ErrorView(message: errorMessage) {
          Task { await loadMessages() }
        }
      } else if isLoading {
        ProgressView("Loading messages...")
          .frame(maxWidth: .infinity, maxHeight: .infinity)
      } else {
        List {
          ForEach(messages, id: \.id) { message in
            ZStack(alignment: .leading) {
              MessageRowView(message: message)
                NavigationLink(value: message) {
                  EmptyView()
                }.opacity(0)
            }.listRowInsets(EdgeInsets(top: 8, leading: 6, bottom: 8, trailing: 6))

              .listRowSeparator(.hidden)

          }
        }
      }
    }
    .navigationTitle("Messages")
    .toolbar {
      ToolbarItem(placement: .topBarTrailing) {
        ToolbarButton(iconName: "NewMessage") {
            DispatchQueue.main.async {
                router.navigateTo(.openMessage(message: nil))
            }
        }
      }
    }
    .task {
      await loadMessages()
    }
    .refreshable {
      await loadMessages()
    }.scrollContentBackground(.hidden)
  }

  private func loadMessages() async {
    isLoading = true
    errorMessage = nil

    do {
      messages = try await catalogueClient.loadMessagesThrows()
    } catch {
      errorMessage = error.localizedDescription
    }

    isLoading = false
  }
}

struct MessagesView_Previews: PreviewProvider {
  static let myEnvObject = CatalogueClient()
  static let myRouterObject = AppRouter(initialTab: AppTab.messages)

  static var previews: some View {
    MessagesView()
      .environment(myRouterObject)
      .environment(myEnvObject)

  }
}
