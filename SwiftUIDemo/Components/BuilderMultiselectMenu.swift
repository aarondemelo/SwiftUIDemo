import SwiftUI

struct BuilderMultiSelectMenuView<Item: Hashable & CustomStringConvertible>: View {
  let title: String
  let allItems: [Item]
  @Binding var selectedItems: Set<Item>
  let textColor: Color

  var body: some View {
    Menu {
      ForEach(allItems, id: \.self) { item in
        Button(action: {
          if selectedItems.contains(item) {
            selectedItems.remove(item)
          } else {
            selectedItems.insert(item)
          }
        }) {
          HStack {
            Text(item.description)
            if selectedItems.contains(item) {
              Image(systemName: "checkmark")
            }
          }
        }
      }
    } label: {
      HStack {
        Text(title)
          .labelL1Semibold(color: textColor)
        Spacer()
        Image(systemName: "chevron.down")
      }
      .padding()
      .cornerRadius(8)
      .overlay(
        RoundedRectangle(cornerRadius: 8)
          .stroke(Color.gray.opacity(0.4))
      )
    }
  }
}
