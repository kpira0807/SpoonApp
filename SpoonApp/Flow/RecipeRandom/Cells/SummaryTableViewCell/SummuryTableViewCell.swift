import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class SummaryTableViewCell: UITableViewCell, Reusable {
    
    var viewModel: SummaryCellViewModel! {
        didSet {
            initializeBindings()
        }
    }
    
    private var disposeBag = DisposeBag()
    
    private lazy var summaryText: UILabel = {
        let summaryText = UILabel()
        summaryText.numberOfLines = 0
        summaryText.clipsToBounds = true
        
        return summaryText
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = .white
        setupLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initializeBindings() {
        viewModel.summary
            .bind(to: summaryText.rx.attributedText)
            .disposed(by: disposeBag)
    }
    
}

extension SummaryTableViewCell {
    
    private func setupLabel() {
        contentView.addSubview(summaryText)
        
        summaryText.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(5.0)
            make.leading.trailing.equalToSuperview().inset(15.0)
        }
    }
    
}
