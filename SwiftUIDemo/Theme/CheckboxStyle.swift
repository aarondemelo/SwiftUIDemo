import SwiftUI

struct CheckboxStyle: ToggleStyle {
  func makeBody(configuration: Configuration) -> some View {
    HStack {
      configuration.label

      Spacer()

      Rectangle()
        .fill(configuration.isOn ? Color.yellow : Color.clear)
        .frame(width: 24, height: 24)
        .overlay(
          RoundedRectangle(cornerRadius: 4)
            .stroke(Color.yellow, lineWidth: 2)
        )
        .overlay(
          Image(systemName: "checkmark")
            .foregroundColor(.black)
            .opacity(configuration.isOn ? 1 : 0)
        )
        .onTapGesture {
          configuration.isOn.toggle()
        }
    }
  }
}
