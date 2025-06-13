import SwiftUI

struct BuilderCheckboxItem: Identifiable {
  let id = UUID()
  let label: String
  let binding: Binding<Bool>
}

struct BuilderCheckboxGroupView: View {
  let title: String
  let items: [BuilderCheckboxItem]
  let textColor: Color

  var body: some View {
    VStack(alignment: .leading, spacing: 20) {
      Text(title)
        .headingH6Medium(color: textColor)

      ForEach(items) { item in
        Toggle(isOn: item.binding) {
          Text(item.label)
            .labelL1Semibold(color: textColor)
        }
        .toggleStyle(CheckboxStyle())
      }
    }
  }
}
