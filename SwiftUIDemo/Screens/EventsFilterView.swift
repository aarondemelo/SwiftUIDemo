import SwiftUI



struct EventsFilterView: View {

  @Environment(AppRouter.self) private var router
  @EnvironmentObject var filterSettings: EventFilterSettings

  private var selectedNeighborhood: String = "Selected Neighborhood"
  private var selectedTags = ["Tribeca", "SoHo", "Chelsea", "West Village"]
    @State private var eventTypeNight = true
    @State private var eventTypeDay = false
    @State private var selectedRange: ClosedRange<Float> = 20...80

  var body: some View {
      
      ScrollView {
          VStack(alignment: .leading, spacing: 25) {
              
              SheetTitleView(title: "Filter Events", closeAction: {
                  router.dismissSheet()
              }).padding(.vertical)
              
              SortOrderSelectorView().padding()
              
              
              VStack(alignment: .leading, spacing: 20) {
                  Text("Event Type").headingH6Medium()
                  Toggle(isOn: $eventTypeNight) {
                      Text("Night").labelL1Semibold()
                  }
                  .toggleStyle(CheckboxStyle())
                  
                  Toggle(isOn: $eventTypeDay) {
                      Text("Day").labelL1Semibold()
                  }
                  .toggleStyle(CheckboxStyle())
              }
              .padding(.horizontal)
              
              VStack(alignment: .leading, spacing: 20) {
                  Text("Neigbourhoods").headingH6Medium().padding(.bottom, 8)
                  
                  Menu {
                      Button("Tribeca", action: {})
                      Button("Chelsea", action: {})
                      // etc.
                  } label: {
                      HStack {
                          Text(selectedNeighborhood).labelL1Semibold()
                          Spacer()
                          Image(systemName: "chevron.down")
                      }
                      .padding()
                      .background(Color.white)
                      .cornerRadius(8)
                      .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray.opacity(0.4)))
                  }
                  
                  Text("Selected (\(selectedTags.count))").paragraphP2Regular()
                  
                  ScrollView(.horizontal, showsIndicators: false) {
                      HStack(spacing: 8) {
                          ForEach(selectedTags, id: \.self) { tag in
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
                  HStack{
                      Text("Price").headingH6Medium().padding(.bottom, 8)
                      Spacer()
                  }
                  
                  BuilderRangeSliderView(value: $selectedRange, bounds: 0...100).frame(height: 20)
                  
                  
              }.padding(.horizontal)
              
          }
      }
      
  }
}



struct EventsFilterView_Previews: PreviewProvider {
    static let themeManager = ThemeManager()
  static let myRouterObject = AppRouter(initialTab: AppTab.events)

  static var previews: some View {
    EventsFilterView()
      .environment(myRouterObject)
      .environmentObject(themeManager)

  }
}
