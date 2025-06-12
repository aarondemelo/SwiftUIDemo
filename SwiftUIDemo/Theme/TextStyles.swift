import SwiftUI

struct BuilderTextStyle: ViewModifier {

  let size: CGFloat
  let weight: Font.Weight
  let color: Color
  let kerning: CGFloat?
  let design: Font.Design?
  var backgroundColor: Color?  // Default background color if needed

  func body(content: Content) -> some View {
    content
      .font(.system(size: size, weight: weight, design: design ?? .default))
      .foregroundColor(color)
      .kerning(kerning ?? 0)
      .background(backgroundColor ?? Color.clear)  // Apply kerning if provided, otherwise 0
  }
}

extension View {

  func headingH6Medium(
    color: Color = Color.basePrimaryDark,
    kerning: CGFloat? = nil,
    design: Font.Design? = nil,
    backgroundColor: Color? = nil
  ) -> some View {
    self.modifier(
      BuilderTextStyle(
        size: 19,  // Similar to .largeTitle
        weight: .regular,
        color: color,
        kerning: kerning,
        design: design,
        backgroundColor: backgroundColor
      ))
  }

  func navBarSmallTitle(
    color: Color = Color.basePrimaryDark,
    kerning: CGFloat? = nil,
    design: Font.Design? = nil
  ) -> some View {
    self.modifier(
      BuilderTextStyle(
        size: 18,  // Similar to .largeTitle
        weight: .semibold,
        color: color,
        kerning: kerning,
        design: design
      ))
  }

  func labelL1Semibold(
    color: Color = Color.basePrimaryDark,
    kerning: CGFloat? = nil,
    design: Font.Design? = nil,
    backgroundColor: Color? = nil
  ) -> some View {
    self.modifier(
      BuilderTextStyle(
        size: 15,  // Similar to .largeTitle
        weight: .semibold,
        color: color,
        kerning: kerning,
        design: design,
        backgroundColor: backgroundColor
      ))
  }

  func paragraphP2Regular(
    color: Color = Color.basePrimaryDark,
    kerning: CGFloat? = nil,
    design: Font.Design? = nil,
    backgroundColor: Color? = nil
  ) -> some View {
    self.modifier(
      BuilderTextStyle(
        size: 13,  // Similar to .largeTitle
        weight: .regular,
        color: color,
        kerning: kerning,
        design: design,
        backgroundColor: backgroundColor
      ))
  }

  func buttonB3Semibold(
    color: Color = Color.basePrimaryNormal,
    kerning: CGFloat? = nil,
    design: Font.Design? = nil,
    backgroundColor: Color? = nil
  ) -> some View {
    self.modifier(
      BuilderTextStyle(
        size: 12,  // Similar to .largeTitle
        weight: .semibold,
        color: color,
        kerning: kerning,
        design: design,
        backgroundColor: backgroundColor
      ))
  }

  func subTitleS1Regular(
    color: Color = Color.basePrimaryDark,
    kerning: CGFloat? = nil,
    design: Font.Design? = nil,
    backgroundColor: Color? = nil
  ) -> some View {
    self.modifier(
      BuilderTextStyle(
        size: 15,  // Similar to .largeTitle
        weight: .regular,
        color: color,
        kerning: kerning,
        design: design,
        backgroundColor: backgroundColor
      ))
  }

}
