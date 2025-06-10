import SwiftUI

struct EventDetailView: View {
  let event: Event

  var body: some View {
    ScrollView {
      VStack(alignment: .leading, spacing: 20) {
        AsyncImage(url: event.imageUrl) { phase in
          if let image = phase.image {
            image
              .resizable()
              .aspectRatio(contentMode: .fit)
              .frame(maxWidth: .infinity)
              .shadow(radius: 5)
          } else if phase.error != nil {
            Image(systemName: "photo")
              .resizable()
              .aspectRatio(contentMode: .fit)
              .frame(maxWidth: .infinity, minHeight: 375)
          } else {
            ProgressView()
              .frame(maxWidth: .infinity, minHeight: 375)
              .background(Color.secondary.opacity(0.1))
          }
        }

        VStack(alignment: .leading) {
          Text(event.title)
            .font(.largeTitle)
            .fontWeight(.bold)

          Text("By \(event.author)")
            .font(.title2)
            .foregroundColor(.secondary)

          Divider()

          Text(
            event.description
          )
          .font(.body)
        }.padding()
      }
    }.ignoresSafeArea()
      .navigationBarTitleDisplayMode(.inline)
  }

}

struct EventDetailsView_Previews: PreviewProvider {
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

    EventDetailView(event: sampleEvent).listRowInsets(EdgeInsets())
      .previewDisplayName("Event Detail Preview")  // Name for the preview in Xcode Canvas
  }
}
