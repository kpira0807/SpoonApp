import UIKit

final class ImageNameCellViewModel {
    
    private let model: ImageNameCellModel
    
    init(model: ImageNameCellModel) {
        self.model = model
    }
    
}

extension ImageNameCellViewModel: CellViewModel {
    
    var height: CGFloat {
        380.0
    }
    
    func setup(cell: ImageNameTableViewCell) {
        cell.viewModel = self
    }
    
}
