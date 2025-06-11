import SwiftUI

struct ProfileView: View {
  @Environment(\.appState) var appState
  @EnvironmentObject var themeManager: ThemeManager
  @Environment(\.colorScheme) private var systemColorScheme

  var body: some View {
    Text("Profile")
      .font(.title)
      .padding()
      .foregroundColor(themeManager.current.background)
    BuilderButton(
      title: "Logout", size: .large, state: .enabled, type: .primary, iconPosition: nil
    ) {
      appState.wrappedValue = .unauthenticated
      //      themeManager.current =
      //        themeManager.current == .dark
      //        ? Theme.light
      //        : Theme.dark
    }
  }
}
