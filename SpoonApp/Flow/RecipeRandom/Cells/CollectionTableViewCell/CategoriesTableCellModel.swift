import Foundation
import RxCocoa
import RxSwift
import UIKit

final class CategoriesTableCellModel: NavigationNode {
    
    var categories = [CategoryRecipe]()
    
    let cellModels = BehaviorRelay(value: [CellModel]())
    
    init(parent: NavigationNode, categories: [CategoryRecipe]) {
        super.init(parent: parent)
        
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
