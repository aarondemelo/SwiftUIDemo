import SwiftUI

struct ComposeMessagesView: View {
  @Environment(AppRouter.self) private var router
  var message: Message?

  var body: some View {
    Text("Compose Messages")
      .font(.title)
      .padding()
  }
}
