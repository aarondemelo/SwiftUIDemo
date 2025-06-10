import SwiftUI

struct ProfileView: View {
  @EnvironmentObject var themeManager: ThemeManager
  @Environment(\.colorScheme) private var systemColorScheme

  var body: some View {
    Text("Profile")
      .font(.title)
      .padding()
      .foregroundColor(themeManager.current.background)
    BuilderButton(
      title: "ANYTHING", size: .large, state: .enabled, type: .primary, iconPosition: nil
    ) {
      themeManager.current =
        themeManager.current == .dark
        ? Theme.light
        : Theme.dark
    }
  }
}
