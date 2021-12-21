import UIKit

class CategoriesCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "CategoriesCollectionViewCell"
    
    private let backCellView: UIView = {
        let backCellView = UIView()
        backCellView.layer.cornerRadius = 8
        backCellView.layer.borderColor = Asset.tabBarTintColor.color.cgColor
        backCellView.layer.borderWidth = 1
        backCellView.clipsToBounds = true
        return backCellView
    }()
    
    private let categotiesLabel: UILabel = {
        let categotiesLabel = UILabel()
        categotiesLabel.textColor = Asset.textColor.color
        categotiesLabel.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        categotiesLabel.numberOfLines = 0
        categotiesLabel.textAlignment = NSTextAlignment.center
        categotiesLabel.clipsToBounds = true
        return categotiesLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        contentView.addSubview(backCellView)
        backCellView.addSubview(categotiesLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        categotiesLabel.text = nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        backCellView.frame = CGRect(x: 0, y: 0, width: contentView.frame.size.width, height: contentView.frame.size.height)
        
        categotiesLabel.frame = CGRect(x: 0, y: 0, width: backCellView.frame.size.width, height: backCellView.frame.size.height)
        
        categotiesLabel.text = "Okay"
    }
}
