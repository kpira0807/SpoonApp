import Foundation

final class SummuryCellModel {
    
}

extension SummuryCellModel: CellModel {
    
    var viewModel: CellAnyViewModel {
        SummuryCellViewModel(model: self)
    }
    
}
