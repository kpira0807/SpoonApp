import RxSwift
import RxCocoa

final class SummaryCellModel {
    
    let summary = BehaviorRelay(value: "")
    
}

extension SummaryCellModel: CellModel {
    
    var viewModel: CellAnyViewModel {
        SummaryCellViewModel(model: self)
    }
    
}
