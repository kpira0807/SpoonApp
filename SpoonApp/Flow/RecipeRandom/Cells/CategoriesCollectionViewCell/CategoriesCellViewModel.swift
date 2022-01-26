import UIKit
import RxSwift
import RxCocoa

final class CategoriesCellViewModel {
    
    var color: Observable<UIColor> {
        if model.categories.value.status == false {
            return  BehaviorRelay(value: Asset.greyLight.color).asObservable()
        } else {
            return  BehaviorRelay(value: Asset.backGreen.color).asObservable()
        }
    }
    
    var categories: Observable<String> {
        BehaviorRelay(value: model.categories.value.name).asObservable()
    }
    
    private let model: CategoriesCellModel
    
    init(model: CategoriesCellModel) {
        self.model = model
    }
    
}

extension CategoriesCellViewModel: CellViewModel {
    
    var height: CGFloat {
        28.0
    }
    
    func setup(cell: CategoriesCollectionViewCell) {
        cell.viewModel = self
    }
    
}
