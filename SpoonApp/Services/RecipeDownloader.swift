import Foundation
import RxCocoa
import RxSwift

protocol RecipeDownloader {
    
    func fetchRecipe(path: RecipeURLPath) -> Observable<RecipeJSON?>
    func fetchRandomRecipe() -> Observable<Recipe?>
    
}

final class RecipeDownloaderManager: RecipeDownloader {
    
    private let session: URLSession
    private let url = URLBuilder()
    
    init(_ session: URLSession =  URLSession.shared) {
        self.session = session
    }
    
    func fetchRecipe(path: RecipeURLPath) -> Observable<RecipeJSON?> {
        guard let url = url.urlBuilder(path: path.rawValue) else { fatalError("Cannot Create URL") }
        let request = URLRequest(url: url)
        
        return session.rx.response(request: request)
            .map { result -> Data in
                
                if (200..<300).contains(result.response.statusCode) {
                    print("Success status: \(result.response.statusCode)")
                }
                else {
                    print( "Failure status \(result.response.statusCode)")
                }
                
                return result.data
            }.map { data in
                do {
                    let apiResponse = try JSONDecoder().decode(
                        RecipeJSON.self, from: data
                    )
                    print("DATA: \(apiResponse)")
                    
                    return apiResponse
                } catch let error {
                    throw FetchError.invalidJSON(error)
                }
            }
            .observeOn(MainScheduler.instance)
            .asObservable()
    }
    
    func fetchRandomRecipe() -> Observable<Recipe?> {
        fetchRecipe(path: .random).map { $0?.recipes.first }
    }
    
}

