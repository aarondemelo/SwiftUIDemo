import SwiftUI

struct ProfileImageSection: View {
  let profileImage: UIImage?
  let placeholderImageUrlString: String
  @Binding var showingImagePicker: Bool

  var body: some View {
    VStack(spacing: 16) {
      if let uiImage = profileImage {
        Image(uiImage: uiImage)
          .resizable()
          .aspectRatio(contentMode: .fill)
          .frame(width: 100, height: 100)
          .clipShape(Circle())
          .overlay(Circle().stroke(Color.gray.opacity(0.3), lineWidth: 1))
      } else {

        BuilderAsyncImageView(
          url: URL(string: placeholderImageUrlString)!,
          size: CGSize(width: 100, height: 100),
          contentMode: .fit,
          shape: .circle,
          placeholderSystemImage: "person.circle.fill"
        )

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
  }
}
