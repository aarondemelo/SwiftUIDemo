import SwiftUI

struct EventRowView: View {
  let event: Event

  var body: some View {
    HStack(alignment: .top) {
      // AsyncImage for loading event image
      AsyncImage(url: event.imageUrl) { phase in
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
        Text(event.title)
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

        Text(event.author)
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

struct EventRowView_Previews: PreviewProvider {
  static var previews: some View {
    let sampleEvent = Event(
      imageUrl: URL(
        string:
          "https://cdn.builder.io/api/v1/image/assets/f2e7f53c455848669d211a7213780279/a21b0b3bcb48491c03fd03d5614b12af2534ceab?placeholderIfAbsent=true"
      )!,  // A sample image URL
      title: "Summer Music Festival",
      author: "City Events Co.",
      neighbourhoods: ["Downtown", "Central Park"],
      dateTime: Date(timeIntervalSinceReferenceDate: 778_944_000),  // Represents a date in the future (e.g., July 15, 2025, 7:00 PM UTC)
      description:
        "Join us for an electrifying music festival featuring local and international artists. Enjoy various genres, food trucks, and art installations.",
      price: 75.50
    )

    // Embed the EventRowView in a List or similar container
    // to see how it would look in a real list context.
    // It's also good practice to give it a fixed size or padding.
    List {
      EventRowView(event: sampleEvent).listRowInsets(EdgeInsets())

    }
    .previewDisplayName("Event Row Preview")  // Name for the preview in Xcode Canvas
  }
}
