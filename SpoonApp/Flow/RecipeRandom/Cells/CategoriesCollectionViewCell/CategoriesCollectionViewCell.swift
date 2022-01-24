import UIKit
import SnapKit
import RxCocoa
import RxSwift

final class CategoriesCollectionViewCell: UICollectionViewCell, Reusable {
    
    static let identifier = String(describing: CategoriesCollectionViewCell.self)
    
    var viewModel: CategoriesCellViewModel! {
        didSet {
            initializeBindings()
        }
    }
    private var disposeBag = DisposeBag()
    
    private lazy var backCellView: UIView = {
        let backCellView = UIView()
        backCellView.layer.cornerRadius = 8.0
        backCellView.layer.borderColor = Asset.tabBarTintColor.color.cgColor
        backCellView.layer.borderWidth = 1.0
        backCellView.clipsToBounds = true
        
        return backCellView
    }()
    
    private lazy var categoriesLabel: UILabel = {
        let categoriesLabel = UILabel()
        categoriesLabel.textColor = Asset.textColor.color
        categoriesLabel.font = .systemFont(ofSize: 12.0, weight: .semibold)
        categoriesLabel.numberOfLines = 0
        categoriesLabel.textAlignment = .center
        categoriesLabel.clipsToBounds = true
        
        return categoriesLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupCategoriesLabel()
        setupBackCellView()
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
    
    private func initializeBindings() {
        
    }
    
}

extension CategoriesCollectionViewCell {
    
    private func setupBackCellView() {
        contentView.addSubview(backCellView)
        
        backCellView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setupCategoriesLabel() {
        backCellView.addSubview(categoriesLabel)
        
        categoriesLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
}
