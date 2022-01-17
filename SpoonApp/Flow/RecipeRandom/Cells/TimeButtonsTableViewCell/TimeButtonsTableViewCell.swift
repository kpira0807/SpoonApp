import UIKit
import SnapKit

class TimeButtonsTableViewCell: UITableViewCell {
    
    static let identifier = String(describing: TimeButtonsTableViewCell.self)
    
    // label with time what need for cook
    private lazy var timeCookLabel: UILabel = {
        let timeCookLabel = UILabel()
        timeCookLabel.textAlignment = NSTextAlignment.left
        timeCookLabel.textColor = Asset.textColor.color
        timeCookLabel.font = UIFont.systemFont(ofSize: 12.0, weight: .regular)
        timeCookLabel.numberOfLines = 0
        timeCookLabel.clipsToBounds = true
        
        return timeCookLabel
    }()
    
    // button for add recipe in save
    private lazy var favouriteButton: UIButton = {
        let favouriteButton = UIButton()
        let image = Asset.heart.name
        favouriteButton.setImage(UIImage(named: image), for: .normal)
        
        return favouriteButton
    }()
    
    // datails information
    private lazy var moreButton: UIButton = {
        let moreButton = UIButton()
        moreButton.setTitle(L10n.moreButton, for: .normal)
        moreButton.setTitleColor(Asset.tabBarTintColor.color, for: .normal)
        moreButton.titleLabel?.font = UIFont.systemFont(ofSize: 12.0)
        moreButton.layer.cornerRadius = 8
        moreButton.layer.borderWidth = 1
        moreButton.layer.borderColor = Asset.tabBarTintColor.color.cgColor
        moreButton.clipsToBounds = true
        
        return moreButton
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = .white
        contentView.addSubview(timeCookLabel)
        contentView.addSubview(favouriteButton)
        contentView.addSubview(moreButton)
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        sizeTimeLabel(time: timeCookLabel)
        sizeFavouriteButton(button: favouriteButton)
        sizeMoreButton(button: moreButton)
    }
    
}

extension TimeButtonsTableViewCell {
    
    func sizeTimeLabel(time: UILabel) {
        time.snp.makeConstraints{ make in
            make.centerY.equalTo(contentView)
            make.leading.equalTo(contentView).offset(20.0)
            make.trailing.equalTo(favouriteButton.snp.leading).offset(-10.0)
        }
    }
    
    func sizeFavouriteButton(button: UIButton) {
        button.snp.makeConstraints{ make in
            make.center.equalTo(contentView)
            make.width.height.equalTo(30.0)
        }
    }
    
    func sizeMoreButton(button: UIButton) {
        button.snp.makeConstraints{ make in
            make.centerY.equalTo(contentView)
            make.trailing.equalTo(contentView).offset(-20.0)
            make.height.equalTo(40.0)
            make.width.equalTo(60.0)
        }
    }
    
}
