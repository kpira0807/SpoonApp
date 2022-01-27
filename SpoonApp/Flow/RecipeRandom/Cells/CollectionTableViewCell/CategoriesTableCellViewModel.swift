import UIKit
import RxCocoa
import RxSwift

final class CategoriesTableCellViewModel {
    
    var cellViewModels: [CellAnyViewModel] {
        model.cellModels.value.map { $0.viewModel }
    }
    
    var reloadData: Observable<Void> {
        model.cellModels.map { _ in }.asObservable()
    }
    
    private let model: CategoriesTableCellModel
    
    init(model: CategoriesTableCellModel) {
        self.model = model
    }
    
}

extension CategoriesTableCellViewModel: CellViewModel {
    
    var height: CGFloat {
        35.0
    }
    
    func setup(cell: CategoriesTableViewCell) {
        cell.viewModel = self
    }
    
}
