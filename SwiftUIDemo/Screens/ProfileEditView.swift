import PhotosUI
import SwiftUI

// MARK: - ProfileEditView

struct ProfileEditView: View {
  @Environment(\.appState) var appState
  @EnvironmentObject var themeManager: ThemeManager
  @Environment(\.dismiss) var dismiss

  @State private var firstName: String
  @State private var lastName: String
  @State private var emailAddress: String
  @State private var profileImage: UIImage? = nil

  @State private var showingImagePicker = false
  @State private var inputImage: UIImage?

  let placeholderImageUrlString: String =
    "https://cdn.builder.io/api/v1/image/assets/f2e7f53c455848669d211a7213780279/19e3f4ef8b50939086b88f10142cd3a5f62adbf9?placeholderIfAbsent=true"

  init() {
    _firstName = State(initialValue: "Amanda")
    _lastName = State(initialValue: "Doe")
    _emailAddress = State(initialValue: "amanda@gmail.com")
    // Initialize profileImage if you have a default user image or fetch it here
  }

  var body: some View {
    VStack(spacing: 0) {
      ProfileImageSection(
        profileImage: profileImage,
        placeholderImageUrlString: placeholderImageUrlString,
        showingImagePicker: $showingImagePicker
      )
      .padding(.top, 24)
      .padding(.bottom, 30)

      VStack(alignment: .leading, spacing: 20) {
        ProfileTextField(title: "First Name", text: $firstName, themeManager: themeManager)
        ProfileTextField(title: "Last Name", text: $lastName, themeManager: themeManager)
        ProfileTextField(
          title: "Email Address", text: $emailAddress, themeManager: themeManager, isEditable: false
        )
      }
      .padding(.horizontal, 24)

      Spacer()
    }
    .navigationTitle("Edit Profile")
    .navigationBarTitleDisplayMode(.inline)
    .toolbar {
      ToolbarItem(placement: .navigationBarTrailing) {
        Button("Save") {
          saveProfile()
          dismiss()
        }
        .foregroundColor(.yellow)
      }
    }
    .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
      BuilderImagePicker(image: $inputImage)
    }
    .background(themeManager.current.background.ignoresSafeArea())
  }

  private func loadImage() {
    guard let inputImage = inputImage else { return }
    profileImage = inputImage
  }

  private func saveProfile() {
    if case .authenticated(var currentUser) = appState.wrappedValue {
      currentUser.firstName = firstName
      currentUser.lastName = lastName
      currentUser.email = emailAddress
      // Potentially save profileImage to storage and update currentUser.profileImageUrl
      appState.wrappedValue = .authenticated(currentUser: currentUser)
    } else {
      print("User not authenticated, cannot save profile.")
    }
  }
}

// MARK: - ProfileTextField

struct ProfileTextField: View {
  let title: String
  @Binding var text: String
  @ObservedObject var themeManager: ThemeManager
  var isEditable: Bool = true

  var body: some View {
    HStack {
      Text(title)
        .font(Font.custom("Inter", size: 14))
        .foregroundColor(themeManager.current.secondaryLight)

      Spacer()

      if isEditable {
        TextField("", text: $text)
          .font(Font.custom("Inter", size: 16))
          .foregroundColor(themeManager.current.text)
          .multilineTextAlignment(.trailing)
          .autocapitalization(.none)
          .disableAutocorrection(true)
      } else {
        Text(text)
          .font(Font.custom("Inter", size: 16))
          .foregroundColor(themeManager.current.text)
      }
    }
    .padding(.vertical, 8)
  }
}

// MARK: - Previews

struct ProfileEditView_Previews: PreviewProvider {
  static let themeManager = ThemeManager()
  static var dummyUser = User(
    firstName: "Amanda",
    lastName: "Doe",
    email: "amanda@gmail.com"
  )

  static var previews: some View {
    NavigationStack {
      ProfileEditView()
        .environmentObject(themeManager)
        .environment(\.appState, .constant(.authenticated(currentUser: dummyUser)))
    }
  }
}
