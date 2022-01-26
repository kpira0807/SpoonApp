import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class CategoriesTableViewCell: UITableViewCell, Reusable {
    
    var viewModel: CategoriesTableCellViewModel! {
        didSet {
            initializedBindings()
        }
    }
    
    private var disposeBag = DisposeBag()
    
    private let collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout.init())
        
        return collectionView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        collectionView.dataSource = self
        collectionView.delegate = self
        
        contentView.backgroundColor = .white
        layoutCollectionView()
        
        setupCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCollectionView() {
        collectionView.registerReusableCell(cellType: CategoriesCollectionViewCell.self)
    }
    
    private func initializedBindings() {
        viewModel.reloadData.subscribe(onNext: { [weak self] _ in
            self?.collectionView.reloadData()
        }).disposed(by: disposeBag)
      }
    
}

extension CategoriesTableViewCell {
    
    private func layoutCollectionView() {
        contentView.addSubview(collectionView)
        
        collectionView.snp.makeConstraints{ make in
            make.edges.equalToSuperview()
        }
        
        let cellSize = CGSize(width: contentView.bounds.width/3, height:30.0)
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
        layout.scrollDirection = .horizontal
        layout.itemSize = cellSize
        layout.sectionInset = UIEdgeInsets(top: 1, left: 1, bottom: 1, right: 1)
        layout.minimumLineSpacing = 2.0
        layout.minimumInteritemSpacing = 2.0
        collectionView.setCollectionViewLayout(layout, animated: true)
    }
    
}

extension CategoriesTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cellViewModel = viewModel.cellViewModels[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withModel: cellViewModel, for: indexPath)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.cellViewModels.count
    }
    
}
