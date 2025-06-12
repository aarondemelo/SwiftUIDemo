import SwiftUI

struct ProfileView: View {
  @Environment(\.appState) var appState
  @EnvironmentObject var themeManager: ThemeManager
  @Environment(\.colorScheme) private var systemColorScheme

  var body: some View {
    let imageUrlString: String =
      "https://cdn.builder.io/api/v1/image/assets/f2e7f53c455848669d211a7213780279/19e3f4ef8b50939086b88f10142cd3a5f62adbf9?placeholderIfAbsent=true"

    VStack {
      HStack(alignment: .center, spacing: 20) {
        AsyncImage(url: URL(string: imageUrlString)) { phase in
          switch phase {
          case .empty:
            // Placeholder while loading
            ProgressView()
              .frame(width: 64, height: 64)
              .background(Color(red: 0.77, green: 0.77, blue: 0.77))
              .cornerRadius(64)
          case .success(let image):
            // Display the loaded image
            image
              .resizable()
              .aspectRatio(contentMode: .fill)
              .frame(width: 64, height: 64)
              .clipped()  // Clip to bounds after filling the frame
              .background(Color(red: 0.77, green: 0.77, blue: 0.77))  // This background might be redundant if the image covers it
              .cornerRadius(64)
          case .failure:
            // Placeholder for failed load (e.g., system icon or solid color)
            Image(systemName: "photo")  // Or a broken image icon
              .resizable()
              .aspectRatio(contentMode: .fit)  // Use fit for system icons
              .frame(width: 64, height: 64)
              .background(Color.gray)  // A different background for error
              .cornerRadius(64)
          @unknown default:
            EmptyView()
          }
        }
        VStack(alignment: .leading, spacing: 4) {
          // Navigation Bar/Small Title
          Text("Amanda Doe")
            .font(
              Font.custom("Inter", size: 18)
                .weight(.bold)
            )
            .foregroundColor(themeManager.current.text)
            .frame(maxWidth: .infinity, alignment: .topLeading)
          // Paragraph/P1 Regular
          Text("amanda@gmail.com")
            .font(Font.custom("Inter", size: 15))
            .kerning(0.5)
            .foregroundColor(themeManager.current.secondaryLight)
            .frame(maxWidth: .infinity, alignment: .topLeading)
        }
        .padding(0)
        .frame(maxWidth: .infinity, alignment: .topLeading)
        Spacer()
      }
      .padding(.horizontal, 16)
      .padding(.vertical, 4)

      VStack(alignment: .leading, spacing: 0) {
        NavigationLink(destination: ProfileEditView()) {
          HStack(alignment: .center, spacing: 0) {
            HStack(alignment: .center, spacing: 0) {
              // Paragraph/P1 Regular
              Text("Edit Profile")
                .font(Font.custom("Inter", size: 15))
                .kerning(0.5)
                .foregroundColor(.black)
                .frame(maxWidth: .infinity, alignment: .topLeading)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 20)
            .frame(maxWidth: .infinity, minHeight: 56, maxHeight: 56, alignment: .leading)
            HStack(alignment: .top, spacing: 0) {
              Image(systemName: "chevron.right")
                .foregroundColor(themeManager.current.text)
            }
            .padding(16)
          }
          .padding(0)
          .frame(alignment: .leading)
        }

        NavigationLink(destination: Text("Notification View")) {
          HStack(alignment: .center, spacing: 0) {
            HStack(alignment: .center, spacing: 0) {
              // Paragraph/P1 Regular
              Text("Notification")
                .font(Font.custom("Inter", size: 15))
                .kerning(0.5)
                .foregroundColor(.black)
                .frame(maxWidth: .infinity, alignment: .topLeading)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 20)
            .frame(maxWidth: .infinity, minHeight: 56, maxHeight: 56, alignment: .leading)
            HStack(alignment: .top, spacing: 0) {
              Image(systemName: "chevron.right")
                .foregroundColor(themeManager.current.text)
            }
            .padding(16)
          }
          .padding(0)
          .frame(alignment: .leading)
        }

        NavigationLink(destination: Text("Terms & Condition View")) {
          HStack(alignment: .center, spacing: 0) {
            HStack(alignment: .center, spacing: 0) {
              // Paragraph/P1 Regular
              Text("Terms & Condition")
                .font(Font.custom("Inter", size: 15))
                .kerning(0.5)
                .foregroundColor(.black)
                .frame(maxWidth: .infinity, alignment: .topLeading)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 20)
            .frame(maxWidth: .infinity, minHeight: 56, maxHeight: 56, alignment: .leading)
            HStack(alignment: .top, spacing: 8) {
              Image(systemName: "chevron.right")
                .foregroundColor(themeManager.current.text)
            }
            .padding(16)
          }
          .padding(0)
          .frame(alignment: .leading)
        }

        HStack {
          // Text label for the theme toggle
          Text("Dark Mode")
            .font(Font.custom("Inter", size: 15))
            .kerning(0.5)
            .foregroundColor(.black)
            .frame(maxWidth: .infinity, alignment: .topLeading)
          // Adjust text color based on the current theme from ThemeManager

          Spacer()  // Pushes the toggle to the right

          Toggle(
            isOn: Binding(
              get: { self.themeManager.current.appColorScheme == .dark },  // When Toggle reads its state
              set: { newValue in  // When Toggle writes its new state
                self.themeManager.current = newValue ? Theme.dark : Theme.light  // Update ThemeManager's theme
              }
            )
          ) {
            // Empty label for the toggle as the Text("Dark Mode") serves as the visual label
            EmptyView()
          }
          .toggleStyle(SwitchToggleStyle(tint: .accentColor)).scaleEffect(0.85).frame(
            alignment: .trailing
          ).padding(.vertical, 0).padding(.trailing, -18)  // Use a standard
        }
        .padding()  // Padding for the HStack content

        Button(action: {
          appState.wrappedValue = .unauthenticated
        }) {
          HStack(alignment: .center, spacing: 0) {
            HStack(alignment: .center, spacing: 0) {  // This inner HStack seems redundant unless there's an icon you removed.
              Text("Logout")
                .font(Font.custom("Inter", size: 15))
                .kerning(0.5)
                .foregroundColor(.red)
                .frame(maxWidth: .infinity, alignment: .topLeading)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 20)
            .frame(maxWidth: .infinity, minHeight: 56, maxHeight: 56, alignment: .leading)
            Spacer()
          }
        }
        .buttonStyle(PlainButtonStyle())
      }
      Spacer()
    }
    .navigationTitle("Profile")

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
