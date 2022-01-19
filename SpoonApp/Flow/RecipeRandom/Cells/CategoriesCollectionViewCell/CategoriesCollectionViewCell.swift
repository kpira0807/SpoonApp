import UIKit
import SnapKit

final class CategoriesCollectionViewCell: UICollectionViewCell, Reusable {
    
    static let identifier = String(describing: CategoriesCollectionViewCell.self)
    
    var viewModel: CategoriesCellViewModel!
    
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
        categoriesLabel.font = .systemFont(ofSize: 12, weight: .semibold)
        categoriesLabel.numberOfLines = 0
        categoriesLabel.textAlignment = .center
        categoriesLabel.clipsToBounds = true
        
        return categoriesLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupCategoriesLabel(categoriesLabel)
        setupBackCellView(backCellView)
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
    
}

extension CategoriesCollectionViewCell {
    
    private func setupBackCellView(_ view: UIView) {
        contentView.addSubview(view)
        
        view.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setupCategoriesLabel(_ label: UILabel) {
        backCellView.addSubview(label)
        
        label.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
}
