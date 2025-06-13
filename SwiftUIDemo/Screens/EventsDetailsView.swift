import SwiftUI

struct EventDetailView: View {

  @EnvironmentObject var themeManager: ThemeManager

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

        ScrollView {
          VStack(alignment: .leading, spacing: 16) {

            ScrollView(.horizontal, showsIndicators: false) {
              HStack(spacing: 12) {

                HStack(spacing: 0) {

                  AsyncImage(url: event.imageUrl) { phase in
                    if let image = phase.image {
                      image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 32, height: 32)
                        .shadow(radius: 5)
                    } else if phase.error != nil {
                      Image(systemName: "person.crop.circle")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 32, height: 32)
                    } else {
                      ProgressView()
                        .frame(width: 32, height: 32)
                        .background(Color.secondary.opacity(0.1))
                    }
                  }.clipShape(Circle())

                  Text(event.author)
                    .buttonB3Semibold(color: Color.black)
                    .lineLimit(1)
                    .truncationMode(.tail)
                    .padding(.horizontal, 12)
                }.frame(height: 32)
                  .background(Color.baseTertiaryNormal)
                  .clipShape(Capsule())

                HStack(spacing: 8) {
                  Text("Tourist")
                    .buttonB3Semibold(color: Color.black)
                    .lineLimit(1)
                    .truncationMode(.tail)
                    .padding(.horizontal, 12)
                }.frame(height: 32)
                  .padding(.horizontal, 5)
                  .padding(.vertical, 0)
                  .background(Color.brandPrimaryNormal)
                  .clipShape(Capsule())
              }
            }

            Text(event.title).navBarLargeTitle(color: themeManager.current.text)

            Text(
              event.description
            ).subTitleS1Regular(color: themeManager.current.text)
          }.padding(.horizontal, 16)
        }
      }
    }.ignoresSafeArea()
      .navigationBarTitleDisplayMode(.inline)
  }

}

struct EventDetailsView_Previews: PreviewProvider {
  static let themeManager = ThemeManager()

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

    EventDetailView(event: sampleEvent).environmentObject(themeManager)

  }
}
