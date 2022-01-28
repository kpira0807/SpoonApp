import RxSwift
import RxCocoa

final class TimeButtonsCellModel {
    
    let time = BehaviorRelay(value: 0)
    
}

extension TimeButtonsCellModel: CellModel {
    
    var viewModel: CellAnyViewModel {
        TimeButtonsCellViewModel(model: self)
    }
    
}
