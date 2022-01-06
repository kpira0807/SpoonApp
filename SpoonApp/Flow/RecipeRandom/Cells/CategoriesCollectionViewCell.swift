import UIKit

final class CategoriesCollectionViewCell: UICollectionViewCell {
    
    static let identifier = String(describing: CategoriesCollectionViewCell.self)
    
    private lazy var backCellView: UIView = {
        let backCellView = UIView()
        backCellView.layer.cornerRadius = 8
        backCellView.layer.borderColor = Asset.tabBarTintColor.color.cgColor
        backCellView.layer.borderWidth = 1
        backCellView.clipsToBounds = true
        backCellView.translatesAutoresizingMaskIntoConstraints = false
        
        return backCellView
    }()
    
    private lazy var categotiesLabel: UILabel = {
        let categotiesLabel = UILabel()
        categotiesLabel.textColor = Asset.textColor.color
        categotiesLabel.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        categotiesLabel.numberOfLines = 0
        categotiesLabel.textAlignment = NSTextAlignment.center
        categotiesLabel.clipsToBounds = true
        categotiesLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return categotiesLabel
    }()
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        categotiesLabel.text = nil
    }
    
    public func configure(categoties: String, backColor: UIColor) {
        categotiesLabel.text = categoties
        backCellView.backgroundColor = backColor
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.addSubview(backCellView)
        
        backCellView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        backCellView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        backCellView.widthAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true
        backCellView.heightAnchor.constraint(equalTo: contentView.heightAnchor).isActive = true
        
        backCellView.addSubview(categotiesLabel)
        
        categotiesLabel.centerXAnchor.constraint(equalTo: backCellView.centerXAnchor).isActive = true
        categotiesLabel.centerYAnchor.constraint(equalTo: backCellView.centerYAnchor).isActive = true
        categotiesLabel.widthAnchor.constraint(equalTo: backCellView.widthAnchor).isActive = true
        categotiesLabel.heightAnchor.constraint(equalTo: backCellView.heightAnchor).isActive = true
    }
}
