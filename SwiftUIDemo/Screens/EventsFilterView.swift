import SwiftUI

struct EventsFilterView: View {

  @Environment(AppRouter.self) private var router
  @Bindable var filterSettings: EventFilterSettings
  @EnvironmentObject var themeManager: ThemeManager

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
          Text("Event Type").headingH6Medium(color: themeManager.current.text)
          Toggle(isOn: eventTypeNightBinding) {
            Text("Night").labelL1Semibold(color: themeManager.current.text)
          }
          .toggleStyle(CheckboxStyle())

          Toggle(isOn: eventTypeDayBinding) {
            Text("Day").labelL1Semibold(color: themeManager.current.text)
          }
          .toggleStyle(CheckboxStyle())
        }
        .padding(.horizontal)

        VStack(alignment: .leading, spacing: 20) {
          Text("Neigbourhoods").headingH6Medium(color: themeManager.current.text).padding(
            .bottom, 8)

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
              Text("Selected Neighborhood").labelL1Semibold(color: themeManager.current.text)
              Spacer()
              Image(systemName: "chevron.down")
            }
            .padding()
            .cornerRadius(8)
            .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray.opacity(0.4)))
          }

          Text("Selected (\(filterSettings.selectedNeighbourhoods.count))").paragraphP2Regular(
            color: themeManager.current.text)

          ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
              ForEach(Array(filterSettings.selectedNeighbourhoods), id: \.self) { tag in
                Text(tag).buttonB3Semibold(color: themeManager.current.text)
                  .padding(.horizontal, 12)
                  .padding(.vertical, 8)
                  .background(Capsule().fill(themeManager.current.buttonDisabledBackground))
              }
            }
          }

        }
        .padding(.horizontal)

        VStack(alignment: .leading, spacing: 20) {

          HStack {
            Text("Price").headingH6Medium(color: themeManager.current.text).padding(.bottom, 8)
            Spacer()
            Text(
              "\(Int(filterSettings.selectedRange.lowerBound))$-\(Int(filterSettings.selectedRange.upperBound))$"
            ).subTitleS1Regular(color: themeManager.current.text).padding(.bottom, 8)

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

  static let themeManager = ThemeManager()
  static let myRouterObject = AppRouter(initialTab: AppTab.events)
  static let eventFilter = EventFilterSettings()

  static var previews: some View {
    EventsFilterView(filterSettings: eventFilter)
      .environment(myRouterObject)
      .environmentObject(themeManager)
  }
}
