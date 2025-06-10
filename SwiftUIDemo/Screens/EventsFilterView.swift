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

struct EventFiltersView: View {

  @Environment(AppRouter.self) private var router

  @State private var selectedSort: String = "Oldest first"
  @State private var eventTypeNight = true
  @State private var eventTypeDay = false
  @State private var selectedNeighborhood: String = "Selected Neighborhood"
  @State private var selectedTags = ["Tribeca", "SoHo", "Chelsea", "West Village"]
  @State private var priceRange: ClosedRange<Double> = 50...130
  @State private var minPrice: Double = 50
  @State private var maxPrice: Double = 130

  let sortOptions = ["Newest First", "Oldest first", "Hight Price First"]

  var body: some View {
    VStack(alignment: .leading, spacing: 16) {
      HStack {
        Button(action: {
          router.dismissSheet()
        }) {
          Image(systemName: "xmark")
        }
        Spacer()
        Text("Event Filters").font(.headline)
        Spacer()
      }
      .padding(.horizontal)

      // Sort
      Text("Sort").font(.headline).padding(.horizontal)
      HStack(spacing: 8) {
        ForEach(sortOptions, id: \.self) { option in
          Button(option) {
            selectedSort = option
          }
          .padding(.horizontal)
          .padding(.vertical, 8)
          .background(selectedSort == option ? Color.yellow : Color.white)
          .foregroundColor(.black)
          .cornerRadius(20)
          .overlay(
            RoundedRectangle(cornerRadius: 20)
              .stroke(Color.yellow, lineWidth: 1)
          )
        }
      }
      .padding(.horizontal)

      // Event Type
      Text("Event Type").font(.headline).padding(.horizontal)
      VStack(alignment: .leading, spacing: 8) {
        Toggle(isOn: $eventTypeNight) {
          Text("Night")
        }
        .toggleStyle(CheckboxStyle())

        Toggle(isOn: $eventTypeDay) {
          Text("Day")
        }
        .toggleStyle(CheckboxStyle())
      }
      .padding(.horizontal)

      // Neighborhoods
      Text("Neighborhoods").font(.headline).padding(.horizontal)
      Menu {
        Button("Tribeca", action: {})
        Button("Chelsea", action: {})
        // etc.
      } label: {
        HStack {
          Text(selectedNeighborhood)
          Spacer()
          Image(systemName: "chevron.down")
        }
        .padding()
        .background(Color.white)
        .cornerRadius(8)
        .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray.opacity(0.4)))
      }
      .padding(.horizontal)

      Text("Selected (\(selectedTags.count))").font(.subheadline).padding(.horizontal)

      ScrollView(.horizontal, showsIndicators: false) {
        HStack(spacing: 8) {
          ForEach(selectedTags, id: \.self) { tag in
            Text(tag)
              .padding(.horizontal, 12)
              .padding(.vertical, 8)
              .background(Color.gray.opacity(0.2))
              .cornerRadius(16)
          }
        }.padding(.horizontal)
      }

      // Price
      Text("Price").font(.headline).padding(.horizontal)
      HStack {
        Text("$\(Int(priceRange.lowerBound))")
        Spacer()
        Text("$\(Int(priceRange.upperBound))")
      }.padding(.horizontal)

      Slider(value: $minPrice, in: 0...130)
        .padding(.horizontal)
      Slider(value: $minPrice, in: priceRange.lowerBound...200)
        .padding(.horizontal)

      Spacer()
    }
    .padding(.top)
  }
}
