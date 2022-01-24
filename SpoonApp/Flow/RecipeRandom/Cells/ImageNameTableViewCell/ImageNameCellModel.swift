import Foundation
import RxSwift
import RxCocoa

final class ImageNameCellModel {
    
    let name: String
    let imageUrl: String

    init(name: String, imageUrl: String) {
        self.name = name
        self.imageUrl = imageUrl
    }
    
}

extension ImageNameCellModel: CellModel {
    
    var viewModel: CellAnyViewModel {
        ImageNameCellViewModel(model: self)
    }
    
}
