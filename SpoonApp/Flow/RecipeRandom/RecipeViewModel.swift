import Foundation
import RxSwift
import RxCocoa

final class RecipeViewModel {
    
    var cellViewModels: [CellAnyViewModel] {
        model.cellModels.value.map{ $0.viewModel }
    }
    
    var loadRandomRecipes: PublishSubject<Void> {
        model.loadRandomRecipe
    }
    
    private let model: RecipeModel
    private let disposeBag = DisposeBag()
    
    init(model: RecipeModel) {
        self.model = model
    }
    
    var reloadData: Observable<Int> {
        model.cellModels.map{ $0.count }
    }
    
}
