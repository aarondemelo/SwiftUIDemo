import Foundation

class User: ObservableObject {
  let id: UUID
  var firstName: String
  var lastName: String
  var email: String
  var profileImageURL: String?
  var dateOfBirth: Date?
  var isActive: Bool
  var createdAt: Date
  var updatedAt: Date

  // Computed properties
  var fullName: String {
    "\(firstName) \(lastName)"
  }

  // Initializer
  init(
    firstName: String, lastName: String, email: String, profileImageURL: String? = nil,
    dateOfBirth: Date? = nil, isActive: Bool = true
  ) {
    self.id = UUID()
    self.firstName = firstName
    self.lastName = lastName
    self.email = email
    self.profileImageURL = profileImageURL
    self.dateOfBirth = dateOfBirth
    self.isActive = isActive
    self.createdAt = Date()
    self.updatedAt = Date()
  }
}
