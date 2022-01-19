import UIKit

final class TimeButtonsCellViewModel {
    
    private let model: TimeButtonsCellModel
    
    init(model: TimeButtonsCellModel) {
        self.model = model
    }
    
}

extension TimeButtonsCellViewModel: CellViewModel {
    
    var height: CGFloat {
        50.0
    }
    
    func setup(cell: TimeButtonsTableViewCell) {
        cell.viewModel = self
    }
    
}
