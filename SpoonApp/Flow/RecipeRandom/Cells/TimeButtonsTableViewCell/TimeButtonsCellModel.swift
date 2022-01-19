import Foundation

final class TimeButtonsCellModel {
    
}

extension TimeButtonsCellModel: CellModel {
    
    var viewModel: CellAnyViewModel {
        TimeButtonsCellViewModel(model: self)
    }
    
}
