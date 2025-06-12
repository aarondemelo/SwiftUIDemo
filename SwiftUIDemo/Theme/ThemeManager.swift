import SwiftUI

struct Theme: Equatable {
  let background: Color
  let text: Color
  let primary: Color
  let secondaryLight: Color
}

class ThemeManager: ObservableObject, Equatable {
  @Published var current: Theme

  // Initialize with system appearance
  init(colorScheme: ColorScheme) {
    self.current = (colorScheme == .light) ? .light : .dark
  }

  static func == (lhs: ThemeManager, rhs: ThemeManager) -> Bool {
    return lhs.current == rhs.current
  }

  func updateTheme(for scheme: ColorScheme) {
    let newTheme: Theme = (scheme == .light) ? .light : .dark
    if self.current != newTheme {
      self.current = newTheme
      print("ThemeManager: Updated theme to \(scheme == .light ? "light" : "dark")")
    }
  }

}

extension Theme {
  static let light = Theme(
    background: .background,
    text: .basePrimaryDark,
    primary: .brandPrimaryNormal,
    secondaryLight: .baseSecondaryLight
  )
  static let dark = Theme(
    background: .darkBackground,
    text: .darkBasePrimaryDark,
    primary: .darkBrandPrimaryNormal,
    secondaryLight: .darkBaseSecondaryLight
  )
}
