import Foundation
import RxCocoa
import RxSwift

protocol ReciperDownloaderProtocol {
    
    func getResponseRecipe() -> Observable<RecipesDetail?>
    func getRecipeImage(withUrl imageUrl: String, completion: @escaping (UIImage) -> ())
    
}

final class ReciperDownloader: ReciperDownloaderProtocol {
    
    private let session: URLSession
    
    init(_ session: URLSession =  URLSession.shared) {
        self.session = session
    }
    
    func getRecipeImage(withUrl imageUrl: String, completion: @escaping (UIImage) -> ()) {
        guard let url = URL(string: imageUrl) else {
            return
        }
        session.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            DispatchQueue.main.async {
                if let image = UIImage(data: data) {
                    completion(image)
                }
            }
        }.resume()
        
    }
    
    private enum FetchError: Error {
        case invalidResponse(URLResponse?)
        case invalidJSON(Error)
    }
    
    func getResponseRecipe() -> Observable<RecipesDetail?> {
        let url = NetworksManager.randomRecipeURL
        let request = URLRequest(url: url)
        
        return session.rx.response(request: request)
            .map { result -> Data in
                guard result.response.statusCode == 200 else {
                    throw FetchError.invalidResponse(result.response)
                }
                return result.data
            }.map { data in
                do {
                    let apiResponse = try JSONDecoder().decode(
                        RecipesDetail.self, from: data
                    )
                    let answer = apiResponse
                    print("DATA: \(answer)")
                    
                    return answer
                } catch let error {
                    throw FetchError.invalidJSON(error)
                }
            }
            .observeOn(MainScheduler.instance)
            .asObservable()
    }
    
}
