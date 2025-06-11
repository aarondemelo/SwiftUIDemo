import SwiftUI

struct MessageRowView: View {
  let message: Message

  var body: some View {
    HStack(alignment: .top) {
      // AsyncImage for loading event image
      AsyncImage(url: message.avatar) { phase in
        if let image = phase.image {
          image
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 45, height: 45)
            .clipShape(RoundedRectangle(cornerRadius: 8))
        } else if phase.error != nil {
          // Fallback for error loading image
          Image(systemName: "photo")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 45, height: 45)
            .foregroundColor(.gray)
            .background(Color.secondary.opacity(0.1))
            .clipShape(RoundedRectangle(cornerRadius: 8))
        } else {
          // Placeholder while loading
          ProgressView()
            .frame(width: 45, height: 45)
            .background(Color.secondary.opacity(0.1))
            .clipShape(RoundedRectangle(cornerRadius: 8))
        }
      }

      VStack(alignment: .leading, spacing: 6) {
        Text(message.name)
          .font(
            .custom(
              "Inter",  // The font family name
              size: 14  // The font size
            )
          )
          .fontWeight(.regular)  // Weight: 400 (regular)
          .lineSpacing(0)  // Line height: 100% (effectively no extra line spacing)
          .kerning(0.25)
          .lineLimit(1)  // Limit to 2 lines for longer titles

        Text(message.message)
          .font(
            .custom(
              "Inter",  // The font family name
              size: 14  // The font size
            )
          )
          .fontWeight(.regular)  // Weight: 400 (regular)
          .lineSpacing(0)  // Line height: 100% (effectively no extra line spacing)
          .kerning(0.25)
          .lineLimit(1)  // Limit to 2 lines for longer titles
          .foregroundColor(.secondary)
      }
    }.padding(.top, 6)
      .padding(.bottom, 6)
    // Vertical padding for each row
  }
}

struct MessageRowView_Previews: PreviewProvider {
  static var previews: some View {
    let sampleMessage = Message(
      avatar: URL(
        string:
          "https://cdn.builder.io/api/v1/image/assets/f2e7f53c455848669d211a7213780279/517ece115990422bf926b34209c8861b8bc169f7?placeholderIfAbsent=true"
      )!,
      name: "John Doe",
      message: "Good for me 🤙"
    )

    // Embed the EventRowView in a List or similar container
    // to see how it would look in a real list context.
    // It's also good practice to give it a fixed size or padding.
    List {
      MessageRowView(message: sampleMessage).listRowInsets(EdgeInsets())

    }
    .previewDisplayName("Event Row Preview")  // Name for the preview in Xcode Canvas
  }
}
