import UIKit

final class SummuryCellViewModel {
    
    private let model: SummuryCellModel
    
    init(model: SummuryCellModel) {
        self.model = model
    }
    
}

extension SummuryCellViewModel: CellViewModel {
    
    var height: CGFloat {
        400.0
    }
    
    func setup(cell: SummuryTableViewCell) {
        cell.viewModel = self
    }
    
}
