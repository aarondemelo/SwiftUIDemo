import SwiftUI

struct ProfileView: View {
  @Environment(\.appState) var appState
  @EnvironmentObject var themeManager: ThemeManager
  @Environment(\.colorScheme) private var systemColorScheme

  let imageUrlString: String =
    "https://cdn.builder.io/api/v1/image/assets/f2e7f53c455848669d211a7213780279/19e3f4ef8b50939086b88f10142cd3a5f62adbf9?placeholderIfAbsent=true"

  var body: some View {
    VStack {
      profileHeader
      menuList
      themeToggle
      logoutButton
      Spacer()
    }
    .navigationTitle("Profile")
  }

  private var profileHeader: some View {
    HStack(alignment: .center, spacing: 20) {
      BuilderAsyncImageView(url: URL(string: imageUrlString), size: CGSize(width: 64, height: 64))

      VStack(alignment: .leading, spacing: 4) {
        Text("Amanda Doe")
          .font(.custom("Inter", size: 18).weight(.bold))
          .foregroundColor(themeManager.current.text)
        Text("amanda@gmail.com")
          .font(.custom("Inter", size: 15))
          .kerning(0.5)
          .foregroundColor(themeManager.current.secondaryLight)
      }
      Spacer()
    }
    .padding(.horizontal, 16)
    .padding(.vertical, 4)
  }

  private var menuList: some View {
    VStack(spacing: 0) {
      menuItem(title: "Edit Profile", destination: ProfileEditView())
      menuItem(title: "Notification", destination: Text("Notification View"))
      menuItem(title: "Terms & Condition", destination: Text("Terms & Condition View"))
    }
  }

  private func menuItem<Destination: View>(title: String, destination: Destination) -> some View {
    NavigationLink(destination: destination) {
      HStack {
        Text(title)
          .font(.custom("Inter", size: 15))
          .kerning(0.5)
          .foregroundColor(themeManager.current.text)
          .frame(maxWidth: .infinity, alignment: .leading)
        Image(systemName: "chevron.right")
          .foregroundColor(themeManager.current.text)
      }
      .padding(.horizontal, 16)
      .padding(.vertical, 20)
      .frame(minHeight: 56, maxHeight: 56)
    }
  }

  private var themeToggle: some View {
    HStack {
      Text("Dark Mode")
        .font(.custom("Inter", size: 15))
        .kerning(0.5)
        .foregroundColor(themeManager.current.text)

      Spacer()

      Toggle(
        isOn: Binding(
          get: { themeManager.current.appColorScheme == .dark },
          set: { newValue in
            themeManager.updateTheme(for: newValue ? .dark : .light)
          })
      ) {
        EmptyView()
      }
      .toggleStyle(SwitchToggleStyle(tint: .accentColor))
      .scaleEffect(0.85)
      .padding(.trailing, -18)
    }
    .padding()
  }

  private var logoutButton: some View {
    Button(action: {
      appState.wrappedValue = .unauthenticated
    }) {
      HStack {
        Text("Logout")
          .font(.custom("Inter", size: 15))
          .kerning(0.5)
          .foregroundColor(.red)
          .frame(maxWidth: .infinity, alignment: .leading)
        Spacer()
      }
      .padding(.horizontal, 16)
      .padding(.vertical, 20)
      .frame(minHeight: 56, maxHeight: 56)
    }
    .buttonStyle(PlainButtonStyle())
  }
}

struct ProfileView_Previews: PreviewProvider {
  static let themeManager = ThemeManager()
  static let myRouterObject = AppRouter(initialTab: AppTab.events)

  static var previews: some View {
    NavigationStack {
      ProfileView()
        .environment(myRouterObject)
        .environmentObject(themeManager)
    }
  }
}
