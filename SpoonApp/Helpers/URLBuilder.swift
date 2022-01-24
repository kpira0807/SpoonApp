import Foundation

final class URLBuilder {
    
    func urlBuilder(path: String) -> URL {
        var components = URLComponents(string: ComponentsURL.baseURL)
        components?.path = path
        components?.queryItems = [URLQueryItem]()
        components?.queryItems?.append(URLQueryItem(name: "apiKey", value: ComponentsURL.apiKey))
        guard let url = components?.url else { fatalError("Cannot Create URL") }
        
        return url
    }
    
}
