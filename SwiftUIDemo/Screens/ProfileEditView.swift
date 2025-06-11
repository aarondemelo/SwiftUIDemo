import PhotosUI
import SwiftUI

struct ProfileEditView: View {
  @Environment(\.appState) var appState
  @EnvironmentObject var themeManager: ThemeManager
  @Environment(\.dismiss) var dismiss

  @State private var firstName: String = "Amanda"
  @State private var lastName: String = "Doe"
  @State private var emailAddress: String = "amanda@gmail.com"
  @State private var profileImage: UIImage? = nil

  let placeholderImageUrlString: String =
    "https://cdn.builder.io/api/v1/image/assets/f2e7f53c455848669d211a7213780279/19e3f4ef8b50939086b88f10142cd3a5f62adbf9?placeholderIfAbsent=true"

  @State private var showingImagePicker = false
  @State private var inputImage: UIImage?

  var body: some View {
    VStack(spacing: 0) {
      VStack(spacing: 16) {
        if let uiImage = profileImage {
          Image(uiImage: uiImage)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 100, height: 100)
            .clipShape(Circle())
            .overlay(Circle().stroke(Color.gray.opacity(0.3), lineWidth: 1))
        } else {
          AsyncImage(url: URL(string: placeholderImageUrlString)) { phase in
            switch phase {
            case .empty:
              ProgressView()
                .frame(width: 100, height: 100)
                .background(Color(red: 0.77, green: 0.77, blue: 0.77))
                .clipShape(Circle())
            case .success(let image):
              image
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 100, height: 100)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.gray.opacity(0.3), lineWidth: 1))
            case .failure:
              Image(systemName: "person.circle.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 100)
                .foregroundColor(.gray)
                .clipShape(Circle())
            @unknown default:
              EmptyView()
            }
          }
        }

        Button("Edit Photo") {
          showingImagePicker = true
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 10)
        .background(Color.yellow.opacity(0.8))
        .foregroundColor(.black)
        .cornerRadius(25)
        .font(.subheadline)
      }
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
          if case .authenticated(var currentUser) = appState.wrappedValue {
            currentUser.firstName = firstName
            currentUser.lastName = lastName
            currentUser.email = emailAddress

            appState.wrappedValue = .authenticated(currentUser: currentUser)
          } else {
            print("User not authenticated, cannot save profile.")
          }

          dismiss()
        }
        .foregroundColor(.yellow)
      }
    }
    .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
      ImagePicker(image: $inputImage)
    }
    .background(themeManager.current.background.ignoresSafeArea())
  }

  func loadImage() {
    guard let inputImage = inputImage else { return }
    profileImage = inputImage
  }
}

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

struct ImagePicker: UIViewControllerRepresentable {
  @Binding var image: UIImage?

  func makeUIViewController(context: Context) -> PHPickerViewController {
    var config = PHPickerConfiguration()
    config.filter = .images
    config.selectionLimit = 1
    let picker = PHPickerViewController(configuration: config)
    picker.delegate = context.coordinator
    return picker
  }

  func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {}

  func makeCoordinator() -> Coordinator {
    Coordinator(self)
  }

  class Coordinator: NSObject, PHPickerViewControllerDelegate {
    var parent: ImagePicker

    init(_ parent: ImagePicker) {
      self.parent = parent
    }

    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
      picker.dismiss(animated: true)

      guard let provider = results.first?.itemProvider else { return }

      if provider.canLoadObject(ofClass: UIImage.self) {
        provider.loadObject(ofClass: UIImage.self) { image, _ in
          DispatchQueue.main.async {
            self.parent.image = image as? UIImage
          }
        }
      }
    }
  }
}

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
