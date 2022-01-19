import Foundation

class NetworksManager {
    
    static let apiKey = "82a59c76fa8548be9aafb1e79b2e39a1"
    static let host = "api.spoonacular.com"
    static let scheme = "https"
    
    static var randomRecipeURL: URL {
        var components = URLComponents()
        components.host = host
        components.path = "/recipes/random"
        components.scheme = scheme
        
        components.queryItems = [URLQueryItem]()
        components.queryItems?.append(URLQueryItem(name: "apiKey", value: NetworksManager.apiKey))
        
        return components.url!
    }
    
}
