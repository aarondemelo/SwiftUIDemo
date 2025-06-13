import SwiftUI

enum AsyncImageShape {
  case circle
  case rounded(CGFloat)
  case rectangle
}

struct BuilderAsyncImageView: View {
  let url: URL?
  let size: CGSize?
  let contentMode: ContentMode
  let shape: AsyncImageShape
  let placeholderSystemImage: String

  init(
    url: URL?,
    size: CGSize? = nil,
    contentMode: ContentMode = .fill,
    shape: AsyncImageShape = .rounded(8),
    placeholderSystemImage: String = "photo"
  ) {
    self.url = url
    self.size = size
    self.contentMode = contentMode
    self.shape = shape
    self.placeholderSystemImage = placeholderSystemImage
  }

  var body: some View {
    AsyncImage(url: url) { phase in
      if let image = phase.image {
        image
          .resizable()
          .aspectRatio(contentMode: contentMode)
          .modifier(ShapeModifier(shape: shape))
      } else if phase.error != nil {
        Image(systemName: placeholderSystemImage)
          .resizable()
          .aspectRatio(contentMode: .fit)
          .foregroundColor(.gray)
          .background(Color.secondary.opacity(0.1))
          .modifier(ShapeModifier(shape: shape))
      } else {
        ProgressView()
          .background(Color.secondary.opacity(0.1))
          .modifier(ShapeModifier(shape: shape))
      }
    }
    .frame(width: size?.width, height: size?.height)
  }
}

private struct ShapeModifier: ViewModifier {
  let shape: AsyncImageShape

  func body(content: Content) -> some View {
    switch shape {
    case .circle:
      content.clipShape(Circle())
    case .rounded(let radius):
      content.clipShape(RoundedRectangle(cornerRadius: radius))
    case .rectangle:
      content
    }
  }
}
