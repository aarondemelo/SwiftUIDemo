import SwiftUI

enum AppColorScheme: String {
  case light, dark
  var id: Self { self }

}

struct Theme: Equatable {
  let background: Color
  let text: Color
  let primary: Color
  let secondaryLight: Color
  let tertiaryDark: Color
  let tertiaryLight: Color
  let buttonDisabledBackground: Color
  let appColorScheme: AppColorScheme
}

class ThemeManager: ObservableObject, Equatable {
  @Published var current: Theme
  @AppStorage("selectedColorScheme") private var selectedColorSchemeRaw: String = AppColorScheme
    .light.rawValue

  init(launchTheme: Theme = Theme.light) {

    current = launchTheme  // Default theme
    if let appColorScheme = AppColorScheme(rawValue: selectedColorSchemeRaw) {
      updateTheme(for: appColorScheme)
    }
  }

  static func == (lhs: ThemeManager, rhs: ThemeManager) -> Bool {
    return lhs.current.appColorScheme == rhs.current.appColorScheme
  }

  func updateTheme(for scheme: AppColorScheme) {
    if self.current.appColorScheme != scheme {
      switch scheme {
      case .light:
        self.current = Theme.light
      case .dark:
        self.current = Theme.dark
      }

      selectedColorSchemeRaw = scheme.rawValue

      print("ThemeManager: Updated theme to \(scheme == .light ? "light" : "dark")")
    }
  }

}

extension Theme {
  static let light = Theme(
    background: .background,
    text: .basePrimaryDark,
    primary: .brandPrimaryNormal,
    secondaryLight: .baseSecondaryLight,
    tertiaryDark: .baseTertiaryDark,
    tertiaryLight: .baseTertiaryLight,
    buttonDisabledBackground: .baseTertiaryNormal,
    appColorScheme: .light
  )
  static let dark = Theme(
    background: .darkBackground,
    text: .darkBasePrimaryDark,
    primary: .darkBrandPrimaryNormal,
    secondaryLight: .darkBaseSecondaryLight,
    tertiaryDark: .darkBaseTertiaryDark,
    tertiaryLight: .darkBaseTertiaryLight,
    buttonDisabledBackground: Color.darkBaseSecondaryNormal,
    appColorScheme: .dark
  )
}
