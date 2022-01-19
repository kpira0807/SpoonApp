import Foundation
import RxCocoa
import RxSwift
import UIKit

final class CategoriesTableCellModel {
    
}

extension CategoriesTableCellModel: CellModel {
    
    var viewModel: CellAnyViewModel {
        CategoriesTableCellViewModel(model: self)
    }
    
}
