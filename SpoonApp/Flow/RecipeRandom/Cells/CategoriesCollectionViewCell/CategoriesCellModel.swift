import Foundation

final class CategoriesCellModel {
    
}

extension CategoriesCellModel: CellModel {
    
    var viewModel: CellAnyViewModel {
        CategoriesCellViewModel(model: self)
    }
    
}
