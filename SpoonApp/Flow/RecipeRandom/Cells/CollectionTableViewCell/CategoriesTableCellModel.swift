import Foundation
import RxCocoa
import RxSwift
import UIKit

final class CategoriesTableCellModel {
    
    var categories = [CategoryRecipe]()
    
    let cellModels = BehaviorRelay(value: [CellModel]())
    
    init(categories: [CategoryRecipe]) {
        self.categories = categories
        prepareCellModels(categories: categories)
    }
    
}

extension CategoriesTableCellModel: CellModel {
    
    var viewModel: CellAnyViewModel {
        CategoriesTableCellViewModel(model: self)
    }
    
    private func prepareCellModels(categories: [CategoryRecipe]) {
        let cellModel: [CellModel] = categories.map { CategoriesCellModel(categories: $0) }
        
        cellModels.accept(cellModel)
    }
    
}
