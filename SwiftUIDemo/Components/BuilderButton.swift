import SwiftUI

//struct ButtonColorTheme {
//  static func border(for state: InputState, scheme: ColorScheme) -> Color {
//    switch state {
//    case .enabled:
//      return scheme == .dark ? Color.white.opacity(0.2) : Color.gray.opacity(0.3)
//    case .pressed:
//      return scheme == .dark ? Color.white : Color.black
//    case .disabled:
//      return scheme == .dark ? Color.gray.opacity(0.2) : Color.gray.opacity(0.1)
//    case .error:
//      return Color.red
//    }
//  }
//
//  static func label(for state: InputState, scheme: ColorScheme) -> Color {
//    switch state {
//    case .enabled, .pressed:
//      return scheme == .dark ? Color.white : Color.black
//    case .disabled:
//      return Color.gray.opacity(0.5)
//    case .error:
//      return Color.red
//    }
//  }
//
//  static func text(for state: InputState, scheme: ColorScheme) -> Color {
//    state == .disabled ? Color.gray.opacity(0.6) : (scheme == .dark ? Color.white : Color.primary)
//  }
//
//  static func background(for state: InputState, scheme: ColorScheme) -> Color {
//    state == .disabled
//      ? Color.gray.opacity(0.1) : (scheme == .dark ? Color.black.opacity(0.3) : Color.white)
//  }
//
//  static func placeHolder(for state: InputState, scheme: ColorScheme) -> Color {
//    state == .disabled
//      ? Color.gray.opacity(0.6) : (scheme == .dark ? .white.opacity(0.6) : Color.gray)
//  }
//
//  static func trailingBackground(for state: InputState) -> Color {
//    switch state {
//    case .disabled:
//      return Color.gray.opacity(0.5)
//    case .error:
//      return Color.red
//    default:
//      return Color.clear
//    }
//  }
//}

enum ButtonSize {
  case large
  case medium
  case small
}
enum ButtonState {
  case enabled
  case pressed
  case disabled
}
enum ButtonType {
  case primary
  case secondary
  case teritary
}

enum ButtonIconPosition {
  case left(Image)
  case right(Image)
}

struct BuilderButton: View {
  let title: String
  let size: ButtonSize
  let state: ButtonState
  let type: ButtonType
  let iconPosition: ButtonIconPosition?
  let action: () -> Void

  @Environment(\.colorScheme) var colorScheme

  var body: some View {
    VStack(alignment: .leading, spacing: 4) {
      HStack {
        Button(title) {
          action()
        }
        //                ZStack(alignment: .leading) {
        //                    Text(label).foregroundColor(ColorTheme.placeHolder(for: state, scheme: colorScheme))
        //                        .offset(y: text.isEmpty ? 0 : -15)
        //                        .scaleEffect(text.isEmpty ? 1 : 0.8, anchor: .leading)
        //
        //                    inputField()
        //
        //                }.frame(minHeight: 46)
        //                    .animation(.easeOut(duration: 0.2), value: text)
        //
        //                if showTrailingButton {
        //                    Button(action:  {
        //                        isSecure.toggle()
        //                        onTrailingButtonTap()
        //                    }) {
        //                        Image(systemName:  (inputType == .password && isSecure) ? trailingIconName : "eye.slash" )
        //                                               .resizable()
        //                                               .scaledToFit()
        //                                               .frame(width: 16, height: 16)
        //                                               .padding(8)
        //                                               .background(ColorTheme.trailingBackground(for: state))
        //                                               .cornerRadius(6)
        //                                       }
        //                                       .buttonStyle(PlainButtonStyle())
        //                }
      }
      .padding(0)
    }
    .padding(.horizontal)
  }

  //    @ViewBuilder
  //    private func inputField() -> some View {
  //        Group {
  //            switch inputType {
  //
  //            case .password where isSecure:
  //                SecureField("", text: $text)
  //            default:
  //                TextField("", text: $text)
  //            }
  //        }
  //        .offset(y: text.isEmpty ? 0 : +8)
  //        .disabled(state == .disabled)
  //        .background(Color.clear)
  //        .foregroundColor(ColorTheme.text(for: state, scheme: colorScheme))
  //    }
}

struct InputPickerField: View {
  let label: String
  let state: InputState
  let pickerOptions: [String]
  @Binding var selectedIndex: Int

  @Environment(\.colorScheme) var colorScheme

  var body: some View {
    VStack(alignment: .leading, spacing: 4) {
      ZStack(alignment: .leading) {
        Text(label)
          .foregroundColor(ColorTheme.placeHolder(for: state, scheme: colorScheme))
          .offset(y: selectedIndex == -1 ? 0 : -15)
          .scaleEffect(selectedIndex == -1 ? 1 : 0.8, anchor: .leading)
          .animation(.easeOut(duration: 0.2), value: selectedIndex)

        Menu {
          ForEach(pickerOptions.indices, id: \.self) { index in
            Button(pickerOptions[index]) {
              selectedIndex = index
            }
          }
        } label: {
          HStack {
            if selectedIndex != -1 {
              Text(pickerOptions[selectedIndex])
                .foregroundColor(ColorTheme.text(for: state, scheme: colorScheme))
            }

            Spacer()
            Image(systemName: "chevron.down")
              .foregroundColor(.gray)
          }
          .padding(.vertical, 10)
          .padding(.horizontal, 6)
        }
        .disabled(state == .disabled)
        .background(Color.clear)
        .offset(y: (selectedIndex != -1) ? +8 : 0)
      }
      .frame(minHeight: 46)
      .padding(.horizontal, 6)
      .overlay(
        RoundedRectangle(cornerRadius: 6)
          .stroke(ColorTheme.border(for: state, scheme: colorScheme), lineWidth: 1)
      )
      .background(ColorTheme.background(for: state, scheme: colorScheme))
      .cornerRadius(6)
    }
    .padding(.horizontal)
  }
}
