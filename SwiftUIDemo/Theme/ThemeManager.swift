import SwiftUI

struct Theme: Equatable {
  let background: Color
  let text: Color
  let primary: Color
  let secondaryLight: Color
}

class ThemeManager: ObservableObject, Equatable {
  @Published var current: Theme = .light

  static func == (lhs: ThemeManager, rhs: ThemeManager) -> Bool {
    return lhs.current == rhs.current
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
