import UIKit
import SnapKit

final class SummuryTableViewCell: UITableViewCell, Reusable {
    
    static let identifier = String(describing: SummuryTableViewCell.self)
    
    var viewModel: SummuryCellViewModel!

    private lazy var summuryText: UILabel = {
        let summuryText = UILabel()
        summuryText.numberOfLines = 0
        summuryText.clipsToBounds = true

        return summuryText
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = .white
        setupLabel(summuryText)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(summury: String) {
        summuryText.text = summury
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        summuryText.text = nil
    }

}

extension SummuryTableViewCell {
    
    private func setupLabel(_ text: UILabel) {
        contentView.addSubview(text)
        
        text.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(5.0)
            make.leading.trailing.equalToSuperview().inset(15.0)
        }
    }
    
}
