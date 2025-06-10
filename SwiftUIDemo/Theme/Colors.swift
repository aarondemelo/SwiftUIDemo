import SwiftUI

extension Color {
  /// Initialize Color from hex string. Example: Color(hex: "#F8D247")
  init(hex: String) {
    let hex =
      hex
      .trimmingCharacters(in: .whitespacesAndNewlines)
      .replacingOccurrences(of: "#", with: "")
    var int: UInt64 = 0
    Scanner(string: hex).scanHexInt64(&int)

    let r: UInt64
    let g: UInt64
    let b: UInt64
    switch hex.count {
    case 6:
      (r, g, b) = ((int >> 16) & 0xFF, (int >> 8) & 0xFF, int & 0xFF)
    default:
      (r, g, b) = (0, 0, 0)
    }

    self.init(
      .sRGB,
      red: Double(r) / 255,
      green: Double(g) / 255,
      blue: Double(b) / 255,
      opacity: 1
    )
  }

  // MARK: - Light Theme Colors

  // Brand Colors
  static let background = Color(hex: "#FFFFFF")
  static let brandPrimaryNormal = Color(hex: "#F8D247")
  static let brandPrimaryLight = Color(hex: "#FAE187")
  static let brandPrimaryDark = Color(hex: "#E0B827")
  static let brandSecondaryNormal = Color(hex: "#274FF5")
  static let brandSecondaryLight = Color(hex: "#6482FF")
  static let brandSecondaryDark = Color(hex: "#1A38B2")
  static let brandTertiaryNormal = Color(hex: "#F87147")
  static let brandTertiaryLight = Color(hex: "#FF9D7E")
  static let brandTertiaryDark = Color(hex: "#E75527")

  // Base Colors
  static let basePrimaryNormal = Color(hex: "#333232")
  static let basePrimaryLight = Color(hex: "#555")
  static let basePrimaryDark = Color(hex: "#000")
  static let baseSecondaryNormal = Color(hex: "#7C7C7C")
  static let baseSecondaryLight = Color(hex: "#ABABAB")
  static let baseSecondaryDark = Color(hex: "#505050")
  static let baseTertiaryNormal = Color(hex: "#EDEEF1")
  static let baseTertiaryLight = Color(hex: "#FFF")
  static let baseTertiaryDark = Color(hex: "#DDD")

  // System Colors
  static let systemSuccessNormal = Color(hex: "#00AF54")
  static let systemSuccessLight = Color(hex: "#24DD7D")
  static let systemSuccessDark = Color(hex: "#0F8849")
  static let systemErrorNormal = Color(hex: "#E03616")
  static let systemErrorLight = Color(hex: "#FD5839")
  static let systemErrorDark = Color(hex: "#BB2D13")

  // MARK: - Dark Theme Colors

  // Brand Colors (same as light theme)
  static let darkBackground = Color(hex: "#141414")
  static let darkBrandPrimaryNormal = Color(hex: "#F8D247")
  static let darkBrandPrimaryLight = Color(hex: "#FAE187")
  static let darkBrandPrimaryDark = Color(hex: "#E0B827")
  static let darkBrandSecondaryNormal = Color(hex: "#274FF5")
  static let darkBrandSecondaryLight = Color(hex: "#6482FF")
  static let darkBrandSecondaryDark = Color(hex: "#1A38B2")
  static let darkBrandTertiaryNormal = Color(hex: "#F87147")
  static let darkBrandTertiaryLight = Color(hex: "#FF9D7E")
  static let darkBrandTertiaryDark = Color(hex: "#E75527")

  // Base Colors (inverted from light theme)
  static let darkBasePrimaryNormal = Color(hex: "#EDEEF1")
  static let darkBasePrimaryLight = Color(hex: "#FFF")
  static let darkBasePrimaryDark = Color(hex: "#DDD")
  static let darkBaseSecondaryNormal = Color(hex: "#7C7C7C")
  static let darkBaseSecondaryLight = Color(hex: "#ABABAB")
  static let darkBaseSecondaryDark = Color(hex: "#505050")
  static let darkBaseTertiaryNormal = Color(hex: "#333232")
  static let darkBaseTertiaryLight = Color(hex: "#555")
  static let darkBaseTertiaryDark = Color(hex: "#000")

  // System Colors (same as light theme)
  static let darkSystemSuccessNormal = Color(hex: "#00AF54")
  static let darkSystemSuccessLight = Color(hex: "#24DD7D")
  static let darkSystemSuccessDark = Color(hex: "#0F8849")
  static let darkSystemErrorNormal = Color(hex: "#E03616")
  static let darkSystemErrorLight = Color(hex: "#FD5839")
  static let darkSystemErrorDark = Color(hex: "#BB2D13")
}
