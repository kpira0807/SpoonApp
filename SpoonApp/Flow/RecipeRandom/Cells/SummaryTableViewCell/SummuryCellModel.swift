import RxSwift
import RxCocoa

final class SummaryCellModel {
    
    let summary: String

    init(summary: String) {
        self.summary = summary
    }

}

extension SummaryCellModel: CellModel {
    
    var viewModel: CellAnyViewModel {
        SummaryCellViewModel(model: self)
    }
    
}
