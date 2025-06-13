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

        BuilderCheckboxGroupView(
          title: "Event Type",
          items: [
            BuilderCheckboxItem(label: "Night", binding: eventTypeNightBinding),
            BuilderCheckboxItem(label: "Day", binding: eventTypeDayBinding),
          ],
          textColor: themeManager.current.text
        ).padding(.horizontal)

        VStack(alignment: .leading, spacing: 20) {
          Text("Neigbourhoods").headingH6Medium(color: themeManager.current.text).padding(
            .bottom, 8)

          BuilderMultiSelectMenuView(
            title: "Selected Neighborhood",
            allItems: filterSettings.availableNeighbourhoods,
            selectedItems: $filterSettings.selectedNeighbourhoods,
            textColor: themeManager.current.text
          )

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
