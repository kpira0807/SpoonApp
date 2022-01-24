import Foundation
import RxCocoa
import RxSwift

protocol ProtocolRecipeDownloader {
    
    func getResponseRecipe(path: RecipeURLPath) -> Observable<RecipeJSON?>
    func getResponseRandomRecipe() -> Observable<Recipe?>
    
}

final class RecipeDownloaderManager: ProtocolRecipeDownloader {
    
    private let session: URLSession
    private let url = URLBuilder()
    
    init(_ session: URLSession =  URLSession.shared) {
        self.session = session
    }
    
    func getResponseRecipe(path: RecipeURLPath) -> Observable<RecipeJSON?> {
        let url = url.urlBuilder(path: path.rawValue)
        let request = URLRequest(url: url)
        
        return session.rx.response(request: request)
            .map { result -> Data in
                
                if 200 ..< 300 ~= result.response.statusCode {
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

    func getResponseRandomRecipe() -> Observable<Recipe?> {
        return getResponseRecipe(path: .random).map { $0?.recipes.first }
    }
    
}

