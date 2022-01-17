import UIKit
import SnapKit

class ImageNameTableViewCell: UITableViewCell {
    
    static let identifier = String(describing: ImageNameTableViewCell.self)
    
    // image for recipe
    private lazy var recipeImage: UIImageView = {
        let recipeImage = UIImageView()
        recipeImage.contentMode = .scaleAspectFill
        recipeImage.image = Asset.food.image
        
        return recipeImage
    }()
    
    // name recipe from json
    private lazy var nameRecipeLabel: UILabel = {
        let nameRecipeLabel = UILabel()
        nameRecipeLabel.textAlignment = NSTextAlignment.center
        nameRecipeLabel.textColor = Asset.textColor.color
        nameRecipeLabel.font = UIFont.systemFont(ofSize: 20.0, weight: .bold)
        nameRecipeLabel.numberOfLines = 0
        nameRecipeLabel.clipsToBounds = true
        
        return nameRecipeLabel
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = .white
        contentView.addSubview(recipeImage)
        contentView.addSubview(nameRecipeLabel)
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        sizeImage(image: recipeImage)
        sizeName(name: nameRecipeLabel)
    }
    
}

extension ImageNameTableViewCell {
    
    func sizeImage(image: UIImageView) {
        image.snp.makeConstraints{ make in
            make.centerX.top.width.equalTo(contentView)
            make.height.equalTo(300.0)
        }
    }
    
    func sizeName(name: UILabel) {
        name.snp.makeConstraints{ make in
            make.centerX.equalTo(contentView)
            make.top.equalTo(recipeImage.snp.bottom).offset(15.0)
            make.leading.equalTo(contentView).offset(15.0)
            make.trailing.equalTo(contentView).offset(-15.0)
        }
    }
    
}
