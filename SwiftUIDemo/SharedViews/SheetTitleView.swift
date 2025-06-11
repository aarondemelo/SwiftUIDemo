import SwiftUI

struct SheetTitleView: View {
  @EnvironmentObject var themeManager: ThemeManager

  let title: String
  let closeAction: () -> Void

  var body: some View {
    HStack {
      Button(action: {
        closeAction()
      }) {
        Image(systemName: "xmark")
      }
      Spacer()
      Text(title).navBarSmallTitle(color: themeManager.current.text)
      Spacer()
    }
    .padding(.horizontal)
  }
}
