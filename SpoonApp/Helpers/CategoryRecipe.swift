import Foundation

struct CategoryRecipe {
    
    let name: String
    let status: Bool
    
    init(name: String = "", status: Bool = false) {
      self.name = name
      self.status = status
    }
    
}
