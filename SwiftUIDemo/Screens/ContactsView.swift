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
  @Environment(AppRouter.self) private var router

  @State private var searchText = ""
  @State private var selectedContact: UUID?

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
      VStack {
          SheetTitleView(
            title: "Contacts",
            closeAction: {
              router.dismissSheet()
            }
          ).padding(.vertical)
          
          List {
              ForEach(filteredSections) { section in
                  Section(
                    header: Text(section.id).font(.headline).foregroundColor(.black).background(
                        Color(UIColor.systemGray5))
                  ) {
                      ForEach(section.contacts) { contact in
                          Text(contact.name)
                              .padding()
                              .frame(maxWidth: .infinity, alignment: .leading)
                              .background(
                                RoundedRectangle(cornerRadius: 4)
                                    .stroke(
                                        contact.id == selectedContact ? Color.purple : Color.clear, lineWidth: 1)
                              )
                              .onTapGesture {
                                  selectedContact = contact.id
                              }
                      }
                  }
              }
          }
          .searchable(text: $searchText)
      }
    
  }
}

struct ContactsView_Previews: PreviewProvider {

  static let myRouterObject = AppRouter(initialTab: AppTab.events)

  static var previews: some View {
    ContactsView()
      .environment(myRouterObject)

  }
}
