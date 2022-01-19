import UIKit

final class CategoriesTableCellViewModel {
    
    private let model: CategoriesTableCellModel
    
    init(model: CategoriesTableCellModel) {
        self.model = model
    }
    
}

extension CategoriesTableCellViewModel: CellViewModel {
    
    var height: CGFloat {
        35.0
    }
    
    func setup(cell: CategoriesTableViewCell) {
        cell.viewModel = self
    }
    
}
