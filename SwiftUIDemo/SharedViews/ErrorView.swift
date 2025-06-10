import SwiftUI

struct ErrorView: View {
  let message: String
  let retryAction: () -> Void

  var body: some View {
    VStack {
      Image(systemName: "exclamationmark.triangle")
        .font(.largeTitle)
        .foregroundColor(.orange)
      Text(message)
        .multilineTextAlignment(.center)
        .padding()
      Button("Retry") {
        retryAction()
      }
      .buttonStyle(.borderedProminent)
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
  }
}
