import SwiftUI

struct LoginView: View {
  @EnvironmentObject var themeManager: ThemeManager
  var onLoginSuccess: (User) -> Void

  @State private var email = ""
  @State private var password = ""
  @State private var selectedOptionIndex = -1
  let options = ["Option 1", "Option 2", "Option 3"]

  var body: some View {
    VStack(spacing: 20) {
      Image("LogoPlaceholder")

      InputTextField(
        label: "Email",
        text: $email,
        state: .enabled,
        showTrailingButton: false,
        trailingIconName: "eye",
        inputType: .email,
        onTrailingButtonTap: {

        }
      )

      InputTextField(
        label: "Password",
        text: $password,
        state: .enabled,
        showTrailingButton: true,
        trailingIconName: "eye",
        inputType: .password,
        onTrailingButtonTap: {

        }
      )

      Button(action: {
        let user = User(
          firstName: "John",
          lastName: "Doe",
          email: "john@example.com"
        )
        onLoginSuccess(user)
      }) {
        Text("Login")
          .frame(maxWidth: .infinity)
          .padding()
          .background(themeManager.current.primary)
          .foregroundColor(.white)
          .cornerRadius(10)
      }

    }
    .padding()
  }
}

struct Login_Previews: PreviewProvider {
  static let themeManager = ThemeManager()
  static let myRouterObject = AppRouter(initialTab: AppTab.events)

  static var previews: some View {
    LoginView(onLoginSuccess: { user in print("user logged in: \(user.firstName) \(user.lastName)")
      })
      .environment(myRouterObject)
      .environmentObject(themeManager)
  }
}
