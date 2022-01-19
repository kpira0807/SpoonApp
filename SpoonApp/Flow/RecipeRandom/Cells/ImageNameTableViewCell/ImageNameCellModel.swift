import Foundation

final class ImageNameCellModel {
    
}

extension ImageNameCellModel: CellModel {
    
    var viewModel: CellAnyViewModel {
        ImageNameCellViewModel(model: self)
    }
    
}
