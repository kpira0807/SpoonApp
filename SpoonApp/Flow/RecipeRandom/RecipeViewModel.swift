import Foundation
import RxSwift

class RecipeViewModel {
    
    private let model: RecipeModel
    
    private let disposeBag = DisposeBag()
    
    init(model: RecipeModel) {
        self.model = model
    }
    
    var updateRecipeData: ((RecipesDetail) -> Void)?
 
    func usersUpdate() -> Observable<RecipesDetail?> {
        
        return Observable.create { [weak self] observer in
            guard let self = self else { return Disposables.create() }
            self.model.getRandomRecipe()
                .subscribe { answer in
                    observer.onNext(answer)
                } onError: { error in
                    print(error)
                } .disposed(by: self.disposeBag)
                            
            return Disposables.create()
        }
    }
}
