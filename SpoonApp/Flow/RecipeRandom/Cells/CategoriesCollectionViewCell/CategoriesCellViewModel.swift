import UIKit

final class CategoriesCellViewModel {
    
    private let model: CategoriesCellModel
    
    init(model: CategoriesCellModel) {
        self.model = model
    }
    
}

extension CategoriesCellViewModel: CellViewModel {
    
    var height: CGFloat {
        28.0
    }
    
    func setup(cell: CategoriesCollectionViewCell) {
        cell.viewModel = self
    }
    
}
