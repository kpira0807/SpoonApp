import UIKit
import RxSwift
import RxRelay

final class TimeButtonsCellViewModel {
    
    var time: Observable<String?> {
        model.time.asObservable().map{ value -> String in
            return String("\(value ?? 0) minutes") }
    }
    
    private let model: TimeButtonsCellModel
    
    init(model: TimeButtonsCellModel) {
        self.model = model
    }
    
}

extension TimeButtonsCellViewModel: CellViewModel {
    
    var height: CGFloat {
        50.0
    }
    
    func setup(cell: TimeButtonsTableViewCell) {
        cell.viewModel = self
    }
    
}
