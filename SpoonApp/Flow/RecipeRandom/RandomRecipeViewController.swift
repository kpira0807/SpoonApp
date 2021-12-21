import UIKit

class RandomRecipeViewController: UIViewController {
    
    private let recipeImage = UIImageView()
    private let nameRecipeLabel = UILabel()

    
    private let collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout.init())
        collectionView.register(CategoriesCollectionViewCell.self, forCellWithReuseIdentifier: CategoriesCollectionViewCell.identifier)
        return collectionView
    }()
//    private let favouriteButton = UIButton()
    private let summuryText = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        nameRecipeLabel.text = "Cake"
        summuryText.text = """
1
2
3
4
"""
        
        collectionView.delegate = self
        collectionView.dataSource = self
        view.addSubview(collectionView)
        
        //   self.navigationItem.title = L10n.recipeTitleVC
        //  self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: Asset.tabBarTintColor.color]
        
        customImage()
        customTitle()
        customCollection()
        customSummuryLabel()
    }

}

extension RandomRecipeViewController {
    
    private func customImage() {
        view.addSubview(recipeImage)
        recipeImage.translatesAutoresizingMaskIntoConstraints = false
        recipeImage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        recipeImage.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        recipeImage.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        recipeImage.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        recipeImage.heightAnchor.constraint(equalToConstant: 250).isActive = true
        recipeImage.image = Asset.food.image
    }
    
    private func customTitle() {
        view.addSubview(nameRecipeLabel)
        nameRecipeLabel.translatesAutoresizingMaskIntoConstraints = false
        nameRecipeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        nameRecipeLabel.topAnchor.constraint(equalTo: recipeImage.bottomAnchor, constant: 10).isActive = true
        nameRecipeLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15).isActive = true
        nameRecipeLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15).isActive = true
        
        nameRecipeLabel.textAlignment = NSTextAlignment.center
        nameRecipeLabel.textColor = Asset.textColor.color
        nameRecipeLabel.font = UIFont.systemFont(ofSize: 20.0, weight: .bold)
        nameRecipeLabel.numberOfLines = 0
        nameRecipeLabel.clipsToBounds = true
    }
    
    private func customCollection() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        collectionView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        collectionView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: nameRecipeLabel.bottomAnchor, constant: 20).isActive = true
        collectionView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        
        let cellSize = CGSize(width: view.bounds.width/3, height:30)

        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
        layout.scrollDirection = .horizontal
        layout.itemSize = cellSize
        layout.sectionInset = UIEdgeInsets(top: 1, left: 1, bottom: 1, right: 1)
        layout.minimumLineSpacing = 1.0
        layout.minimumInteritemSpacing = 1.0
        collectionView.setCollectionViewLayout(layout, animated: true)
        collectionView.reloadData()
    }
    
    private func customSummuryLabel() {
        view.addSubview(summuryText)
        summuryText.translatesAutoresizingMaskIntoConstraints = false
        summuryText.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        summuryText.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 10).isActive = true
        summuryText.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15).isActive = true
        summuryText.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15).isActive = true
        summuryText.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        summuryText.textAlignment = NSTextAlignment.justified
        summuryText.textColor = Asset.textColor.color
        summuryText.font = UIFont.systemFont(ofSize: 14.0, weight: .regular)
        summuryText.numberOfLines = 0
        summuryText.clipsToBounds = true
    }
}

extension RandomRecipeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoriesCollectionViewCell.identifier, for: indexPath) as? CategoriesCollectionViewCell else {
            return UICollectionViewCell()
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
}
