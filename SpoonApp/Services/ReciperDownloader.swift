import Foundation

protocol ReciperDownloaderProtocol {
    func getReciperResponse(success: @escaping (RecipesDetail) -> Void, failure: @escaping (Error) -> Void)
}

final class ReciperDownloader: ReciperDownloaderProtocol {
    
    private let reciperURL = "https://api.spoonacular.com/recipes/random?apiKey=82a59c76fa8548be9aafb1e79b2e39a1"
    private let session: URLSession
    
    init(_ session: URLSession =  URLSession.shared) {
        self.session = session
    }
    
    func getReciperResponse(success: @escaping (RecipesDetail) -> Void, failure: @escaping (Error) -> Void) {
        guard let url = URL(string: reciperURL) else { return }
        session.dataTask(with: url) { (data, _, error) in
            if let error = error {
                print("Error: ", error)
                failure(error)
                return
            }
            guard let data = data else { return }
            do {
                let data = try JSONDecoder().decode(RecipesDetail.self, from: data)
                success(data)
                print(data)
            } catch let jsonError {
                print(jsonError)
                failure(jsonError)
            }
        }.resume()
    }
}
