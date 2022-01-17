import UIKit
import SnapKit

class CategoriesTableViewCell: UITableViewCell {
    
    static let identifier = String(describing: CategoriesTableViewCell.self)
    
    private let collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout.init())
        collectionView.register(CategoriesCollectionViewCell.self, forCellWithReuseIdentifier: CategoriesCollectionViewCell.identifier)
        
        return collectionView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = .white
        contentView.addSubview(collectionView)
        
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        sizeCollection(collection: collectionView)
    }

}

extension CategoriesTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func sizeCollection(collection: UICollectionView) {
        collection.snp.makeConstraints{ make in
            make.edges.equalTo(contentView)
        }
        
        let cellSize = CGSize(width: contentView.bounds.width/3, height:28.0)
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
        layout.scrollDirection = .horizontal
        layout.itemSize = cellSize
        layout.sectionInset = UIEdgeInsets(top: 1, left: 1, bottom: 1, right: 1)
        layout.minimumLineSpacing = 1.0
        layout.minimumInteritemSpacing = 1.0
        collection.setCollectionViewLayout(layout, animated: true)
        collection.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoriesCollectionViewCell.identifier, for: indexPath) as? CategoriesCollectionViewCell else {
            
            return UICollectionViewCell()
        }
        // cell.configure(categoties: "Okay", backColor: .white)
        /*
        if categoryRecipe[indexPath.row].status == false {
            cell.configure(categoties: categoryRecipe[indexPath.row].name, backColor: Asset.greyLight.color)
        } else {
            cell.configure(categoties: categoryRecipe[indexPath.row].name, backColor: Asset.backGreen.color)
        }
       */
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 8
    }

}
