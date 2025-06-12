import SwiftUI

struct Contact: Identifiable {
  let id = UUID()
  let name: String
}

struct SectionedContacts: Identifiable {
  let id: String
  let contacts: [Contact]
}

struct ContactsView: View {
  @Environment(AppRouter.self) private var router  // Assuming AppRouter is defined
  @Environment(\.dismiss) var dismiss  // New: Use environment dismiss for sheet

  @State private var searchText = ""
  @State private var selectedContact: UUID?
  @EnvironmentObject var themeManager: ThemeManager

  // Dummy data as provided
  private var allContacts: [Contact] = [
    Contact(name: "Abraham Lincoln"),
    Contact(name: "Agnes Code"),
    Contact(name: "Amanda Nunes"),
    Contact(name: "Andrew Knicks"),
    Contact(name: "Barney"),
    Contact(name: "Britney Spears"),
    Contact(name: "Bob Ross"),
    Contact(name: "Charlie Puth"),
    Contact(name: "Carmen Sandiego"),
    Contact(name: "Diana Prince"),
    Contact(name: "Dwayne Johnson"),
    Contact(name: "Dexter Morgan"),
    Contact(name: "Eleanor Shellstrop"),
    Contact(name: "Elon Musk"),
    Contact(name: "Fiona Gallagher"),
    Contact(name: "Fred Flintstone"),
    Contact(name: "George Costanza"),
    Contact(name: "Gina Linetti"),
    Contact(name: "Harry Potter"),
    Contact(name: "Harvey Specter"),
    Contact(name: "Homer Simpson"),
    Contact(name: "Isaac Newton"),
    Contact(name: "Ivy League"),
    Contact(name: "Jack Sparrow"),
    Contact(name: "Jessica Jones"),
    Contact(name: "Jim Halpert"),
    Contact(name: "John Wick"),
    Contact(name: "Kendall Roy"),
    Contact(name: "Kim Possible"),
    Contact(name: "Larry Page"),
    Contact(name: "Lorelai Gilmore"),
    Contact(name: "Michael Scott"),
    Contact(name: "Monica Geller"),
    Contact(name: "Nancy Drew"),
    Contact(name: "Neo"),
    Contact(name: "Olivia Benson"),
    Contact(name: "Oprah Winfrey"),
    Contact(name: "Phoebe Buffay"),
    Contact(name: "Pikachu"),
    Contact(name: "Quentin Tarantino"),
    Contact(name: "Rachel Green"),
    Contact(name: "Rick Sanchez"),
    Contact(name: "Ron Swanson"),
    Contact(name: "Samantha Carter"),
    Contact(name: "Sheldon Cooper"),
    Contact(name: "Sherlock Holmes"),
    Contact(name: "Steve Jobs"),
    Contact(name: "Tony Stark"),
    Contact(name: "Tina Fey"),
    Contact(name: "Uma Thurman"),
    Contact(name: "Violet Baudelaire"),
    Contact(name: "Walter White"),
    Contact(name: "Will Smith"),
    Contact(name: "Winston Bishop"),
    Contact(name: "Xander Harris"),
    Contact(name: "Yoda"),
    Contact(name: "Zelda Fitzgerald"),
  ]

  var filteredSections: [SectionedContacts] {
    let filtered =
      searchText.isEmpty
      ? allContacts
      : allContacts.filter { $0.name.lowercased().contains(searchText.lowercased()) }

    let grouped = Dictionary(grouping: filtered) { contact in
      String(contact.name.prefix(1)).uppercased()
    }

    return
      grouped
      .sorted { $0.key < $1.key }
      .map { SectionedContacts(id: $0.key, contacts: $0.value) }
  }

  var body: some View {
    NavigationStack {
      ScrollView {
        VStack(spacing: 0) {
          ForEach(filteredSections) { section in
            VStack(alignment: .leading, spacing: 0) {
              Text(section.id)
            }
            .padding(.leading, 16)
            .padding(.trailing, 8)
            .padding(.vertical, 8)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color(red: 0.87, green: 0.87, blue: 0.87))
            //              .background(themeManager.current.tertiaryDark)

            VStack(spacing: 0) {
              ForEach(section.contacts) { contact in
                HStack(alignment: .center, spacing: 0) {
                  HStack(alignment: .center, spacing: 8) {
                    // Paragraph/P1 Regular
                    Text(contact.name)
                      .font(Font.custom("Inter", size: 15))
                      .kerning(0.5)
                      .foregroundColor(
                        themeManager.current.text
                      )
                      .frame(maxWidth: .infinity, alignment: .topLeading)
                  }
                  .padding(.horizontal, 16)
                  .padding(.vertical, 20)
                  .frame(maxWidth: .infinity, minHeight: 56, maxHeight: 56, alignment: .leading)
                }
                .padding(0).frame(maxWidth: .infinity, alignment: .leading)
                .background(Color.white)
                //                  .background(themeManager.current.tertiaryLight)
                .overlay(alignment: .bottom) {
                  Rectangle()
                    .frame(height: 0.5)  // Adjust thickness as needed
                    .foregroundColor(.gray.opacity(0.4))  // Adjust color and opacity as needed
                }
                .onTapGesture {
                  NotificationCenter.default.post(
                    name: .selectedContactName,
                    object: nil,
                    userInfo: ["message": contact.name, "timestamp": Date()]
                  )
                  dismiss()
                }
              }
            }
          }
        }
      }
      .navigationTitle("Contacts")  // Set the title here
      .navigationBarTitleDisplayMode(.inline)  // Makes title appear inline at the top
      .toolbar {
        ToolbarItem(placement: .topBarLeading) {
          Button(action: {
            router.dismissSheet()  // Use router to dismiss the sheet if needed
          }) {
            Image(systemName: "xmark")
          }
        }
      }
    }
    .searchable(text: $searchText)  // Apply searchable to the NavigationStack
  }
}

struct ContactsView_Previews: PreviewProvider {

  static let myRouterObject = AppRouter(initialTab: AppTab.events)
  static let themeManager = ThemeManager()

  static var previews: some View {
    ContactsView()
      .environment(myRouterObject)
      .environmentObject(themeManager)
  }
}
