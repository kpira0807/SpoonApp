import Foundation
import RxSwift
import RxCocoa

final class RecipeViewModel {
    
    var cellViewModels: [CellAnyViewModel] {
        model.cellModels.value.map { $0.viewModel }
    }
    
    var loadRandomRecipes: PublishSubject<Void> {
        model.loadRandomRecipe
    }
    
    var detailButtonAction: PublishSubject<Void> {
      model.detailButtonAction
    }
    
    var saveRecipe: PublishSubject<Void> {
        model.saveAction
    }
    
    var deleteRecipe: PublishSubject<Void> {
        model.deleteAction
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
