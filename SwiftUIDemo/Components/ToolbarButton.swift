import SwiftUI

struct ToolbarButton: View {
  let iconName: String
  let action: () -> Void

  var body: some View {
    Button(action: action) {
      Image(iconName)
        .resizable()
        .scaledToFit()
        .frame(width: 18, height: 18)  // Adjust size as needed
        .foregroundColor(.black)
        .padding(12)  // Padding around the image
        .background(Circle().fill(Color.yellow))
    }
  }
}
