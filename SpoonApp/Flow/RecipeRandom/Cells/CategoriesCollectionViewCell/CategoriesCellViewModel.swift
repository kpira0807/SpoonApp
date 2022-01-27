import UIKit
import RxSwift
import RxCocoa

final class CategoriesCellViewModel {
    
    var color: Observable<UIColor> {
        model.categories.map{
            $0.status ? Asset.backGreen.color : Asset.greyLight.color
        }
    }
    
    var name: Observable<String> {
        model.categories.map{ $0.name }
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
