import RxSwift
import RxCocoa

final class SummaryCellModel {
    
    var summary = BehaviorRelay<String?>(value: "")
    
}

extension SummaryCellModel: CellModel {
    
    var viewModel: CellAnyViewModel {
        SummaryCellViewModel(model: self)
    }
    
}
