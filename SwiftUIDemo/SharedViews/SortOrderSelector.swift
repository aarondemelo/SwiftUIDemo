import SwiftUI

struct SortOrderSelectorView: View {

  @State private var selectedSortOrder: SortOrder = .newestFirst

  // Environment object for theme management (optional, but good practice if integrated)
  @EnvironmentObject var themeManager: ThemeManager  // Assuming this is set up in a parent view

  var body: some View {

    VStack(alignment: .leading) {
      Text("Sort").headingH6Medium().padding(.bottom, 8)

      ScrollView(.horizontal, showsIndicators: false) {
        HStack(spacing: 10) {
          // Iterate over all cases of the SortOrder enum
          ForEach(SortOrder.allCases) { order in
            Button(action: {
              selectedSortOrder = order
            }) {
              Text(order.rawValue)
                .buttonB3Semibold(
                  color: selectedSortOrder == order ? Color.white : themeManager.current.text
                )
                .padding(.vertical, 8)
                .padding(.horizontal, 15)
                .background(
                  // Background color changes based on selection
                  Capsule()
                    .fill(selectedSortOrder == order ? Color.brandPrimaryNormal : Color.clear)
                )
                .overlay(
                  Capsule()
                    .stroke(Color.brandPrimaryNormal, lineWidth: 1)
                )
            }
            .buttonStyle(PlainButtonStyle())  // To remove default button styling
          }
        }
      }
    }
  }
}

// MARK: - Preview Provider
/// Provides a preview of the SortOrderSelectorView in Xcode's canvas.
struct SortOrderSelectorView_Previews: PreviewProvider {
  static var previews: some View {
    SortOrderSelectorView()
      // Inject a ThemeManager for the preview to work correctly with EnvironmentObject
      .environmentObject(ThemeManager(colorScheme: .dark))
  }
}
