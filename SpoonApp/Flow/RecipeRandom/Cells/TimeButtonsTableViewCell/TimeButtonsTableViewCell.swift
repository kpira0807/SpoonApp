import UIKit
import SnapKit

final class TimeButtonsTableViewCell: UITableViewCell, Reusable {
    
    static let identifier = String(describing: TimeButtonsTableViewCell.self)
    
    var viewModel: TimeButtonsCellViewModel!
    
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
    
    private lazy var addToFavouriteButton: UIButton = {
        let addToFavouriteButton = UIButton()
        addToFavouriteButton.setImage(Asset.heart.image, for: .normal)
        
        return addToFavouriteButton
    }()
    
    private lazy var openDetailInfoButton: UIButton = {
        let openDetailInfoButton = UIButton()
        openDetailInfoButton.setTitle(L10n.moreButton, for: .normal)
        openDetailInfoButton.setTitleColor(Asset.tabBarTintColor.color, for: .normal)
        openDetailInfoButton.titleLabel?.font = .systemFont(ofSize: 12.0)
        openDetailInfoButton.layer.cornerRadius = 8
        openDetailInfoButton.layer.borderWidth = 1
        openDetailInfoButton.layer.borderColor = Asset.tabBarTintColor.color.cgColor
        openDetailInfoButton.clipsToBounds = true
        
        return openDetailInfoButton
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = .white
        
        setupTimeLabel(timeCookLabel)
        setupFavouriteButton(addToFavouriteButton)
        setupMoreButton(openDetailInfoButton)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(time: String) {
        timeCookLabel.text = time
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        timeCookLabel.text = nil
    }
    
}

extension TimeButtonsTableViewCell {
    
    private func setupTimeLabel(_ time: UILabel) {
        contentView.addSubview(time)
        
        time.snp.makeConstraints{ make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(20.0)
            make.trailing.equalTo(contentView.snp.centerX).offset(-25.0)
        }
    }
    
    private func setupFavouriteButton(_ button: UIButton) {
        contentView.addSubview(button)
        
        button.snp.makeConstraints{ make in
            make.center.equalToSuperview()
            make.width.height.equalTo(30.0)
        }
    }
    
    private func setupMoreButton(_ button: UIButton) {
        contentView.addSubview(button)
        
        button.snp.makeConstraints{ make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-20.0)
            make.height.equalTo(40.0)
            make.width.equalTo(60.0)
        }
    }
    
}
