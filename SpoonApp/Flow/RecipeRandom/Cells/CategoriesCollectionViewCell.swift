import UIKit
import SnapKit

final class CategoriesCollectionViewCell: UICollectionViewCell {
    
    static let identifier = String(describing: CategoriesCollectionViewCell.self)
    
    private lazy var backCellView: UIView = {
        let backCellView = UIView()
        backCellView.layer.cornerRadius = 8
        backCellView.layer.borderColor = Asset.tabBarTintColor.color.cgColor
        backCellView.layer.borderWidth = 1
        backCellView.clipsToBounds = true
        
        return backCellView
    }()
    
    private lazy var categoriesLabel: UILabel = {
        let categoriesLabel = UILabel()
        categoriesLabel.textColor = Asset.textColor.color
        categoriesLabel.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        categoriesLabel.numberOfLines = 0
        categoriesLabel.textAlignment = NSTextAlignment.center
        categoriesLabel.clipsToBounds = true

        return categoriesLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        categoriesLabel.text = nil
    }
    
    public func configure(categoties: String, backColor: UIColor) {
        categoriesLabel.text = categoties
        backCellView.backgroundColor = backColor
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.addSubview(backCellView)
        backCellView.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
        }

        backCellView.addSubview(categoriesLabel)
        categoriesLabel.snp.makeConstraints { make in
            make.edges.equalTo(backCellView)
        }
    }
    
}
