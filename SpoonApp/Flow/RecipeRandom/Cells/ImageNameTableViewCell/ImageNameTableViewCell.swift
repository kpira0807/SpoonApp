import UIKit
import SnapKit
import RxSwift
import RxCocoa
import Kingfisher

final class ImageNameTableViewCell: UITableViewCell, Reusable {
    
    var viewModel: ImageNameCellViewModel! {
        didSet {
            initializeBindings()
        }
    }
    
    private var disposeBag = DisposeBag()
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
        setupImage()
        setupName()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        
        nameRecipeLabel.text = nil
        recipeImage.image = nil
    }
    
    private func initializeBindings() {
        viewModel.name
            .bind(to: nameRecipeLabel.rx.text)
            .disposed(by: disposeBag)


        viewModel.image.subscribe(onNext: { [weak self] imageUrl in
            guard let url = URL.init(string: imageUrl) else {
                return
            }
            self?.recipeImage.kf.setImage(with: ImageResource.init(downloadURL: url))
        }).disposed(by: disposeBag)
    }
    
}

extension ImageNameTableViewCell {
    
    private func setupImage() {
        contentView.addSubview(recipeImage)
        
        recipeImage.snp.makeConstraints{ make in
            make.trailing.leading.top.equalToSuperview()
            make.height.equalTo(300.0)
        }
    }
    
    private func setupName() {
        contentView.addSubview(nameRecipeLabel)
        
        nameRecipeLabel.snp.makeConstraints{ make in
            make.top.equalTo(recipeImage.snp.bottom).offset(15.0)
            make.leading.trailing.equalToSuperview().inset(15.0)
        }
    }
    
}
