import Foundation
import RxCocoa
import RxSwift

protocol ReciperDownloaderProtocol {
    
    /// For RxSwift for future
    // func getResponseRecipe() -> Observable<RecipesDetail?>
    func getResponseRecipe(success: @escaping (RecipesDetail) -> Void)
}

final class ReciperDownloader: ReciperDownloaderProtocol {
    
    private var networksManager = NetworksManager()
    private var recipeURL: String {
        get  {
            
            return "\(networksManager.urlRendomRecipe)?apiKey=\(networksManager.apiKey)"
        }
    }
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
    
    ///For RxSwift for Future
/*
    private enum FetchError: Error {
            case invalidResponse(URLResponse?)
            case invalidJSON(Error)
        }
    
    func getResponseRecipe() -> Observable<RecipesDetail?> {
        
        guard let url = URL(string: "\(networksManager.urlRendomRecipe)?apiKey=\(networksManager.apiKey)") else {
            return Observable.just(nil)
        }
        
        let request = URLRequest(url: url)
        return URLSession.shared.rx.response(request: request)
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
 */
}

