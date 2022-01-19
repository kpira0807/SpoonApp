import UIKit
import SnapKit

final class ImageNameTableViewCell: UITableViewCell, Reusable {
    
    static let identifier = String(describing: ImageNameTableViewCell.self)
    
    var viewModel: ImageNameCellViewModel!
    
    private lazy var recipeImage: UIImageView = {
        let recipeImage = UIImageView()
        recipeImage.contentMode = .scaleAspectFill
        recipeImage.image = Asset.food.image
        
        return recipeImage
    }()
    
    private lazy var nameRecipeLabel: UILabel = {
        let nameRecipeLabel = UILabel()
        nameRecipeLabel.textAlignment = .center
        nameRecipeLabel.textColor = Asset.textColor.color
        nameRecipeLabel.font = .systemFont(ofSize: 20.0, weight: .bold)
        nameRecipeLabel.numberOfLines = 0
        nameRecipeLabel.clipsToBounds = true
        
        return nameRecipeLabel
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = .white
        setupImage(recipeImage)
        setupName(nameRecipeLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(image: UIImage, name: String) {
        recipeImage.image = image
        nameRecipeLabel.text = name
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        nameRecipeLabel.text = nil
        recipeImage.image = nil
    }
    
}

extension ImageNameTableViewCell {
    
    private func setupImage(_ image: UIImageView) {
        contentView.addSubview(image)
        
        image.snp.makeConstraints{ make in
            make.trailing.leading.top.equalToSuperview()
            make.height.equalTo(300.0)
        }
    }
    
    private func setupName(_ name: UILabel) {
        contentView.addSubview(name)
        
        name.snp.makeConstraints{ make in
            make.top.equalTo(recipeImage.snp.bottom).offset(15.0)
            make.leading.trailing.equalToSuperview().inset(15.0)
        }
    }
    
}
