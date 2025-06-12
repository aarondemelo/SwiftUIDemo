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
    NavigationStack {  // Use NavigationStack for modern navigation and toolbar capabilities
      VStack(spacing: 0) {
        // SheetTitleView is now replaced by toolbar items
        List {
          ForEach(filteredSections) { section in
            Section(
              header: HStack {
                Text(section.id)
                  .font(.headline)
                  .foregroundColor(.black)
                  .padding(.horizontal, 12)
                Spacer()
              }
              .frame(maxWidth: .infinity, minHeight: 30)
              .background(Color(UIColor.systemGray5))
            ) {
              ForEach(section.contacts) { contact in
                Text(contact.name)
                  .frame(maxWidth: .infinity, alignment: .leading)
                  .onTapGesture {
                    NotificationCenter.default.post(
                      name: .selectedContactName,
                      object: nil,
                      userInfo: ["message": contact.name, "timestamp": Date()]
                    )
                    // Using @Environment(\.dismiss) directly for dismissing the sheet
                    dismiss()
                  }
                  .padding(.horizontal, 12)
              }
            }
          }
        }
        .listStyle(.plain)
        .padding(.horizontal, -18)  // Remove default list padding
        .listSectionSpacing(0)
        .listRowSeparator(Visibility.visible, edges: .all)
      }
      .navigationTitle("Contacts")  // Set the title here
      .navigationBarTitleDisplayMode(.inline)  // Makes title appear inline at the top
      .toolbar {
        // MARK: - Close Button (Trailing)
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
  static let themeManager = ThemeManager(colorScheme: .dark)

  static var previews: some View {
    ContactsView()
      .environment(myRouterObject)
      .environmentObject(themeManager)
  }
}
