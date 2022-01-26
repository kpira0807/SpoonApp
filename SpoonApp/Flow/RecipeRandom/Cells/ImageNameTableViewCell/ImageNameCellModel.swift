import Foundation
import RxSwift
import RxCocoa

final class ImageNameCellModel {
    
    var name = BehaviorRelay<String?>(value: "")
    var imageUrl = BehaviorRelay<String?>(value: "")
    
}

extension ImageNameCellModel: CellModel {
    
    var viewModel: CellAnyViewModel {
        ImageNameCellViewModel(model: self)
    }
    
}
