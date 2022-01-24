import RxSwift
import RxCocoa

final class TimeButtonsCellModel {
    
    let time: String

    init(time: String) {
        self.time = time
    }
    
}

extension TimeButtonsCellModel: CellModel {
    
    var viewModel: CellAnyViewModel {
        TimeButtonsCellViewModel(model: self)
    }
    
}
