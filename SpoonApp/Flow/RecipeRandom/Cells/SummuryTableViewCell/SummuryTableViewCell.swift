import UIKit
import SnapKit

class SummuryTableViewCell: UITableViewCell {
    
    static let identifier = String(describing: SummuryTableViewCell.self)

    private lazy var summuryText: UILabel = {
        let summuryText = UILabel()
        summuryText.numberOfLines = 0
        summuryText.clipsToBounds = true
        
        return summuryText
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = .white
        contentView.addSubview(summuryText)
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        sizeSummuryText(text: summuryText)
    }

}

extension SummuryTableViewCell {
    
    func sizeSummuryText(text: UILabel) {
        summuryText.snp.makeConstraints{ make in
            make.centerX.bottom.equalTo(contentView)
            make.top.equalTo(contentView).offset(5.0)
            make.leading.equalTo(contentView).offset(15.0)
            make.trailing.equalTo(contentView).offset(-15.0)
        }
    }
    
}
