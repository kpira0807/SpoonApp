import Foundation

struct URLBuilder {
    
    func urlBuilder(path: String) -> URL? {
        var components = URLComponents(string: ComponentsURL.baseURL)
        components?.path = path
        components?.queryItems = [URLQueryItem]()
        components?.queryItems?.append(URLQueryItem(name: "apiKey", value: ComponentsURL.apiKey))
        let url = components?.url
        
        return url
    }
    
}
