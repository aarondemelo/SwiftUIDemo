import SwiftUI

struct ComposeMessageView: View {
  @Environment(AppRouter.self) private var router
  @EnvironmentObject var themeManager: ThemeManager

  @State var message: Message?

  var body: some View {

    VStack(spacing: 0) {

      ScrollView {
        Rectangle()
          .fill(Color.gray.opacity(0.3))
          .frame(maxWidth: .infinity, minHeight: 600, maxHeight: .infinity)  // Small space above the input field

      }.padding(0)
      Spacer()
      // Spacer pushes the input field down
      // Input field
      HStack {

        TextField("Type a message...", text: .constant("")).labelL1Semibold(
          color: themeManager.current.text
        )
        .padding(.horizontal, 8)
        .padding(.vertical, 12)

        Button(action: {
          print("Send tapped")
        }) {
          Image(systemName: "paperplane.fill")
            .rotationEffect(.degrees(45))
        }.padding(.horizontal, 8)
      }.background(
        RoundedRectangle(cornerRadius: 4)
          .stroke(Color.gray.opacity(0.3), lineWidth: 1)
          .background(
            RoundedRectangle(cornerRadius: 20)
              .fill(Color(UIColor.systemBackground))
          )
      )
      .padding(.vertical, 6)
      .padding(.horizontal, 12)
      .background(Color(UIColor.systemBackground))

    }  // Padding for the input field row
    .padding(.bottom, 8)
    .toolbar {

      ToolbarItem(placement: .principal) {  // .principal for center alignment
        HStack(spacing: 8) {

          if message?.avatar != nil {
            AsyncImage(url: message!.avatar) { phase in
              if let image = phase.image {
                image
                  .resizable()
                  .aspectRatio(contentMode: .fit)
                  .frame(width: 24, height: 24)
                  .shadow(radius: 5)
              } else if phase.error != nil {
                Image(systemName: "person.crop.circle")
                  .resizable()
                  .aspectRatio(contentMode: .fit)
                  .frame(width: 24, height: 24)
              } else {
                ProgressView()
                  .frame(width: 24, height: 24)
                  .background(Color.secondary.opacity(0.1))
              }
            }
          }

          Text(message?.name ?? "").navBarSmallTitle(color: themeManager.current.text)
        }
      }

      // Right-aligned Delete button
      ToolbarItem(placement: .navigationBarTrailing) {
        Button("Delete") {
          // Action for delete button
          print("Delete button tapped!")
        }
        .foregroundColor(.yellow)  // Yellow color for "Delete" as in the image
      }
    }
  }

}

// MARK: - Preview Provider
struct MessageScreen_Previews: PreviewProvider {
  static let themeManager = ThemeManager()
  static let myRouterObject = AppRouter(initialTab: AppTab.events)

  static var previews: some View {
    ComposeMessageView()
      .environment(myRouterObject)
      .environmentObject(themeManager)

  }
}
