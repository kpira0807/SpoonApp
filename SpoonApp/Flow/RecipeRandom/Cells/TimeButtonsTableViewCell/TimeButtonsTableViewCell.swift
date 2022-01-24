import UIKit
import SnapKit
import RxCocoa
import RxSwift

final class TimeButtonsTableViewCell: UITableViewCell, Reusable {
    
    var viewModel: TimeButtonsCellViewModel! {
        didSet {
            initializeBindings()
        }
    }
    
    private var disposeBag = DisposeBag()
    
    // label with time what need for cook
    private lazy var timeCookLabel: UILabel = {
        let timeCookLabel = UILabel()
        timeCookLabel.textAlignment = .left
        timeCookLabel.textColor = Asset.textColor.color
        timeCookLabel.font = UIFont.systemFont(ofSize: 12.0, weight: .regular)
        timeCookLabel.numberOfLines = 0
        timeCookLabel.clipsToBounds = true
        
        return timeCookLabel
    }()
    
    private lazy var timeCookImage: UIImageView = {
        let timeCookImage = UIImageView()
        timeCookImage.contentMode = .scaleAspectFill
        timeCookImage.image = Asset.cookingTime.image
        
        return timeCookImage
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = .white
        
        setupTimeImage()
        setupTimeLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        
        timeCookLabel.text = nil
    }
    
    private func initializeBindings() {
        viewModel.time
            .bind(to: timeCookLabel.rx.text)
            .disposed(by: disposeBag)
    }
    
}

extension TimeButtonsTableViewCell {
    
    private func setupTimeImage() {
        contentView.addSubview(timeCookImage)
        
        timeCookImage.snp.makeConstraints{ make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(15.0)
            make.height.width.equalTo(35)
        }
    }
    
    private func setupTimeLabel() {
        contentView.addSubview(timeCookLabel)
        
        timeCookLabel.snp.makeConstraints{ make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(timeCookImage.snp.trailing).offset(20.0)
            make.trailing.equalToSuperview()
        }
    }
    
}
