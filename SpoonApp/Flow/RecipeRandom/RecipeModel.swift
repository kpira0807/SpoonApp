import Foundation
import RxSwift

final class RecipeModel: NavigationNode {

    private let downloader: ReciperDownloaderProtocol
    private let storage: ReciperStorageProtocol
    
    private let disposeBag = DisposeBag()
    
    init(parent: NavigationNode,
         downloader: ReciperDownloaderProtocol = ReciperDownloader(),
         storage: ReciperStorageProtocol = ReciperStorage()
    ) {
        
        self.downloader = downloader
        self.storage = storage
        
        super.init(parent: parent)
    }

    func getRandomRecipe() -> Observable<RecipesDetail?> {
        
        return Observable.create { observer in
            self.downloader.getResponseRecipe()
                .subscribe { recipe in
                    if let answer = recipe {
                        observer.onNext(answer)
                      //  observer.on(.next(answer))
                        print("ANSWER -- \(answer)")
                    }
                } onError: { error in
                    print(error)
                } .disposed(by: self.disposeBag)
            
            return Disposables.create()
        }
    }
    
    func saveFavouriteRecipe(_ recipe: RecipeSaveModel) {
        storage.saveRecipe(recipe)
    }
}
