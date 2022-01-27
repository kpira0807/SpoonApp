import UIKit
import RxSwift
import RxCocoa

final class SummaryCellViewModel {
    
    var summary: Observable<NSAttributedString?> {
        model.summary.map{
            return $0.convertHtmlToAttributedStringWithCSS(font: UIFont.systemFont(ofSize: 14.0), csscolor: "black", lineheight: 5, csstextalign: "justify")
        }
    }
    
    private let model: SummaryCellModel
    
    init(model: SummaryCellModel) {
        self.model = model
    }
    
}

extension SummaryCellViewModel: CellViewModel {
    
    var height: CGFloat {
        400.0
    }
    
    func setup(cell: SummaryTableViewCell) {
        cell.viewModel = self
    }
    
}
