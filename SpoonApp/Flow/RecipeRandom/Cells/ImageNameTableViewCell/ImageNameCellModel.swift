import Foundation
import RxSwift
import RxCocoa

final class ImageNameCellModel {
    
    let name = BehaviorRelay(value: "")
    let imageStringUrl = BehaviorRelay(value: "")
    
}

extension ImageNameCellModel: CellModel {
    
    var viewModel: CellAnyViewModel {
        ImageNameCellViewModel(model: self)
    }
    
}
