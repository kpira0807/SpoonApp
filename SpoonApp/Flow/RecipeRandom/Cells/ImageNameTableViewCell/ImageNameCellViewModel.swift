import UIKit
import RxCocoa
import RxSwift
import Kingfisher

final class ImageNameCellViewModel {
    
    var name: Observable<String> {
        return BehaviorRelay.init(value: model.name).asObservable()
    }
    
    var image: Observable<String> {
        return BehaviorRelay.init(value: model.imageUrl).asObservable()
    }
    
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
