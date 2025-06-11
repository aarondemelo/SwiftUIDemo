import SwiftUI

struct BuilderTextStyle: ViewModifier {

    let size: CGFloat
    let weight: Font.Weight
    let color: Color
    let kerning: CGFloat?
    let design: Font.Design?

    func body(content: Content) -> some View {
        content
            .font(.system(size: size, weight: weight, design: design ?? .default))
            .foregroundColor(color)
            .kerning(kerning ?? 0) // Apply kerning if provided, otherwise 0
    }
}


extension View {
    
    func navBarSmallTitle(
        color: Color = Color.basePrimaryDark,
        kerning: CGFloat? = nil,
        design: Font.Design? = nil
    ) -> some View {
        self.modifier(BuilderTextStyle(
            size: 18, // Similar to .largeTitle
            weight: .semibold,
            color: color,
            kerning: kerning,
            design: design
        ))
    }
    
}
