import Foundation
import RxSwift
import RxCocoa

final class CategoriesCellModel {

    var categories = BehaviorRelay(value: CategoryRecipe(name: "", status: false))
    
    init(_ categories: CategoryRecipe) {
        self.categories.accept(categories)
    }
    
}

extension CategoriesCellModel: CellModel {
    
    var viewModel: CellAnyViewModel {
        CategoriesCellViewModel(model: self)
    }
    
}
