import SwiftUI

struct EventsFilterView: View {

  @Environment(AppRouter.self) private var router
  @Bindable var filterSettings: EventFilterSettings

  var eventTypeNightBinding: Binding<Bool> {
    Binding<Bool>(
      get: {
        filterSettings.eventTimeOfDay.contains(.night)
      },
      set: { newValue in
        if newValue {
          filterSettings.eventTimeOfDay.insert(.night)
        } else {
          filterSettings.eventTimeOfDay.remove(.night)
        }
      }
    )
  }

  var eventTypeDayBinding: Binding<Bool> {
    Binding<Bool>(
      get: {
        filterSettings.eventTimeOfDay.contains(.day)
      },
      set: { newValue in
        if newValue {
          filterSettings.eventTimeOfDay.insert(.day)
        } else {
          filterSettings.eventTimeOfDay.remove(.day)
        }
      }
    )
  }

  var body: some View {

    ScrollView {
      VStack(alignment: .leading, spacing: 25) {

        SheetTitleView(
          title: "Filter Events",
          closeAction: {
            router.dismissSheet()
          }
        ).padding(.vertical)

        SortOrderSelectorView(selectedSortOrder: $filterSettings.sortOrder)
          .padding(.horizontal)

        VStack(alignment: .leading, spacing: 20) {
          Text("Event Type").headingH6Medium()
          Toggle(isOn: eventTypeNightBinding) {
            Text("Night").labelL1Semibold()
          }
          .toggleStyle(CheckboxStyle())

          Toggle(isOn: eventTypeDayBinding) {
            Text("Day").labelL1Semibold()
          }
          .toggleStyle(CheckboxStyle())
        }
        .padding(.horizontal)

        VStack(alignment: .leading, spacing: 20) {
          Text("Neigbourhoods").headingH6Medium().padding(.bottom, 8)

          Menu {
            ForEach(filterSettings.availableNeighbourhoods, id: \.self) { neighborhood in
              Button(action: {
                if filterSettings.selectedNeighbourhoods.contains(neighborhood) {
                  filterSettings.selectedNeighbourhoods.remove(neighborhood)
                } else {
                  filterSettings.selectedNeighbourhoods.insert(neighborhood)
                }
              }) {
                HStack {
                  Text(neighborhood)
                  if filterSettings.selectedNeighbourhoods.contains(neighborhood) {
                    Image(systemName: "checkmark")
                  }
                }
              }
            }
          } label: {
            HStack {
              Text("Selected Neighborhood").labelL1Semibold()
              Spacer()
              Image(systemName: "chevron.down")
            }
            .padding()
            .background(Color.white)
            .cornerRadius(8)
            .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray.opacity(0.4)))
          }

          Text("Selected (\(filterSettings.selectedNeighbourhoods.count))").paragraphP2Regular()

          ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
              ForEach(Array(filterSettings.selectedNeighbourhoods), id: \.self) { tag in
                Text(tag).buttonB3Semibold()
                  .padding(.horizontal, 12)
                  .padding(.vertical, 8)
                  .background(Capsule().fill(Color.baseTertiaryNormal))
              }
            }
          }

        }
        .padding(.horizontal)

        VStack(alignment: .leading, spacing: 20) {

          HStack {
            Text("Price").headingH6Medium().padding(.bottom, 8)
            Spacer()
            Text(
              "\(Int(filterSettings.selectedRange.lowerBound))$-\(Int(filterSettings.selectedRange.upperBound))$"
            ).subTitleS1Regular().padding(.bottom, 8)

          }

          ItsukiSlider(
            value: $filterSettings.selectedRange, in: filterSettings.priceRange, step: 2,
            barStyle: (height: 6, cornerRadius: 6)
          )
          .frame(height: 12)

        }.padding(.horizontal)

      }
    }

  }
}

struct EventsFilterView_Previews: PreviewProvider {

  static let themeManager = ThemeManager(colorScheme: .dark)
  static let myRouterObject = AppRouter(initialTab: AppTab.events)
  static let eventFilter = EventFilterSettings()

  static var previews: some View {
    EventsFilterView(filterSettings: eventFilter)
      .environment(myRouterObject)
      .environmentObject(themeManager)
  }
}
