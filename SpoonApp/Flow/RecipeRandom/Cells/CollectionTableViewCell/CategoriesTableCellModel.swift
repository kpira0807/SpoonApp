import Foundation
import RxCocoa
import RxSwift
import UIKit

final class CategoriesTableCellModel: NavigationNode {
        
    let cellModels = BehaviorRelay(value: [CellModel]())

    init(parent: NavigationNode) {
        super.init(parent: parent)

        prepareCellModels()
    }
    
}

extension CategoriesTableCellModel: CellModel {
    
    var viewModel: CellAnyViewModel {
        CategoriesTableCellViewModel(model: self)
    }
    
    private func prepareCellModels() {
        let categoriesCellModel = CategoriesCellModel()
        
        cellModels.accept([categoriesCellModel])
    }
    
}
