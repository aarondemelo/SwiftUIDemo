import Combine
import Foundation

class AuthModel: ObservableObject {
  @Published private(set) var isAuthenticated: Bool = false
  @Published private(set) var token: String?

  func login(username: String, password: String) {
    // Simulate authentication
    guard username == "user" && password == "password" else {
      isAuthenticated = false
      token = nil
      return
    }

    // Simulate token received
    token = "dummy_token_123"
    isAuthenticated = true
  }

  func logout() {
    token = nil
    isAuthenticated = false
  }
}
