import RxSwift
import RxCocoa

final class TimeButtonsCellModel {
    
    var time = BehaviorRelay<Int?>(value: 0)
    
}

extension TimeButtonsCellModel: CellModel {
    
    var viewModel: CellAnyViewModel {
        TimeButtonsCellViewModel(model: self)
    }
    
}
