import SwiftUI



struct EventsFilterView: View {

  @Environment(AppRouter.self) private var router
  @EnvironmentObject var filterSettings: EventFilterSettings

  private var selectedNeighborhood: String = "Selected Neighborhood"
  private var selectedTags = ["Tribeca", "SoHo", "Chelsea", "West Village"]


  var body: some View {
      
      VStack(alignment: .leading, spacing: 16) {
          
          SheetTitleView(title: "Filter Events", closeAction: {
                router.dismissSheet()
            })
          Spacer()
          
          
          
      }
      
      
      
      

//
//      // Sort
//      Text("Sort").font(.headline).padding(.horizontal)
//      HStack(spacing: 8) {
//          ForEach(SortOrder.allCases, id: \.self) { option in
//          Button(option) {
//              $filterSettings.sortOrder = option
//          }
//          .padding(.horizontal)
//          .padding(.vertical, 8)
//          .background($filterSettings.sortOrder == option ? Color.yellow : Color.white)
//          .foregroundColor(.black)
//          .cornerRadius(20)
//          .overlay(
//            RoundedRectangle(cornerRadius: 20)
//              .stroke(Color.yellow, lineWidth: 1)
//          )
//        }
//      }
//      .padding(.horizontal)
//
//      // Event Type
//      Text("Event Type").font(.headline).padding(.horizontal)
//      VStack(alignment: .leading, spacing: 8) {
//          Toggle(isOn: $filterSettings.eventTimeOfDay.contains(.night)) {
//          Text("Night")
//        }
//        .toggleStyle(CheckboxStyle())
//
//          Toggle(isOn: $filterSettings.eventTimeOfDay.contains(.day)) {
//
//          Text("Day")
//        }
//        .toggleStyle(CheckboxStyle())
//      }
//      .padding(.horizontal)
//
//      // Neighborhoods
//      Text("Neighborhoods").font(.headline).padding(.horizontal)
//      Menu {
//        Button("Tribeca", action: {})
//        Button("Chelsea", action: {})
//        // etc.
//      } label: {
//        HStack {
//          Text(selectedNeighborhood)
//          Spacer()
//          Image(systemName: "chevron.down")
//        }
//        .padding()
//        .background(Color.white)
//        .cornerRadius(8)
//        .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray.opacity(0.4)))
//      }
//      .padding(.horizontal)
//
//      Text("Selected (\(selectedTags.count))").font(.subheadline).padding(.horizontal)
//
////      ScrollView(.horizontal, showsIndicators: false) {
////        HStack(spacing: 8) {
////          ForEach(selectedTags, id: \.self) { tag in
////            Text(tag)
////              .padding(.horizontal, 12)
////              .padding(.vertical, 8)
////              .background(Color.gray.opacity(0.2))
////              .cornerRadius(16)
////          }
////        }.padding(.horizontal)
////      }
//
//      // Price
////      Text("Price").font(.headline).padding(.horizontal)
////      HStack {
////        Text("$\(Int(priceRange.lowerBound))")
////        Spacer()
////        Text("$\(Int(priceRange.upperBound))")
////      }.padding(.horizontal)
////
////      Slider(value: $minPrice, in: 0...130)
////        .padding(.horizontal)
////      Slider(value: $minPrice, in: priceRange.lowerBound...200)
////        .padding(.horizontal)
//
////      Spacer()
    
      EmptyView()

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
