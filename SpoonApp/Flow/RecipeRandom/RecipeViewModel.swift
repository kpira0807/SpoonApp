import Foundation
import RxSwift
import RxCocoa

final class RecipeViewModel {
    
    var cellViewModels: [CellAnyViewModel] {
      model.cellModels.value.map { $0.viewModel }
    }
    
    private let model: RecipeModel
    private let disposeBag = DisposeBag()
    
    init(model: RecipeModel) {
        self.model = model
    }
    
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

    func buttonAction() -> UIViewController {
        let vc = model.detailButton()
        
        return vc
    }
    
}
