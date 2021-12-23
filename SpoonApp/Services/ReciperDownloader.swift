import Foundation

protocol ReciperDownloaderProtocol {
    func getResponseRecipe(success: @escaping (RecipesDetail) -> Void)
}

final class ReciperDownloader: ReciperDownloaderProtocol {
    
    private let recipeURL = "https://api.spoonacular.com/recipes/random?apiKey=82a59c76fa8548be9aafb1e79b2e39a1"
    private let session: URLSession
    
    init(_ session: URLSession =  URLSession.shared) {
        
        self.session = session
    }
    
    func getResponseRecipe(success: @escaping (RecipesDetail) -> Void) {
        guard let url = URL(string: recipeURL) else { return }
        session.dataTask(with: url) { (data, _, error) in
            if let error = error {
                print("Error: ", error)
                
                return
            }
            guard let data = data else { return }
            do {
                let data = try JSONDecoder().decode(RecipesDetail.self, from: data)
                success(data)
                print("DATA: \(data)")
            } catch let jsonError {
                print(jsonError)
                
            }
        }.resume()
    }
}
