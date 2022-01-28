import Foundation
import RxSwift
import RxCocoa

final class CategoriesCellModel {
    
    var categories = BehaviorRelay(value: CategoryRecipe())
    
    init(categories: CategoryRecipe) {
        self.categories.accept(categories)
    }
    
}

extension CategoriesCellModel: CellModel {
    
    var viewModel: CellAnyViewModel {
        CategoriesCellViewModel(model: self)
    }
    
}
