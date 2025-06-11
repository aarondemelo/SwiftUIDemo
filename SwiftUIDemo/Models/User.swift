import Foundation

class User: ObservableObject {
  let id: UUID
  var firstName: String
  var lastName: String
  var email: String
  var profileImageURL: String?

  // Computed properties
  var fullName: String {
    "\(firstName) \(lastName)"
  }

  // Initializer
  init(
    firstName: String, lastName: String, email: String, profileImageURL: String? = nil
  ) {
    self.id = UUID()
    self.firstName = firstName
    self.lastName = lastName
    self.email = email
    self.profileImageURL = profileImageURL
  }
}
