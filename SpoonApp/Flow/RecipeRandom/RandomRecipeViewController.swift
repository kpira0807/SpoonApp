import UIKit

class RandomRecipeViewController: UIViewController {
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    private let recipeImage = UIImageView()
    private let nameRecipeLabel = UILabel()
    
    private let viewBackButton = UIView()
    private let timeCookLabel = UILabel()
    private let favouriteButton = UIButton()
    private let moreButton = UIButton()
    
    private let collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout.init())
        collectionView.register(CategoriesCollectionViewCell.self, forCellWithReuseIdentifier: CategoriesCollectionViewCell.identifier)
        return collectionView
    }()
    
    private let summuryText = UILabel()

    private let viewModel: RecipeViewModel
    
    
    init?(_ viewModel: RecipeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = L10n.recipeTitleVC
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: Asset.textColor.color]
        
        view.backgroundColor = .white
        
        timeCookLabel.text = "40 minutes"
      
        collectionView.delegate = self
        collectionView.dataSource = self
        
        setupScrollView()
        
        customRecipeImage()
        setupViewsRecioeImage()
        
        customNameRecipeLabel()
        setupViewsNameRecipeLabel()
        
        setupViewsCollection()
        customCollection()
        
        setupViewsBackButtons()
        customViewButton()
        customTimeLabel()
        customMoreButton()
        customFavouriteButton()
        
        setupViewsSummuryText()
        customSummuryLabel()
        
        setup()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.userDidShake()
    }
    
    private func setup() {
        viewModel.updateRecipeData = { [weak self] recipe in
            self?.updateRecipe(recipe)
        }
    }

    var collectionItems = [String: Bool]()
    
    private func updateRecipe(_ recipe: RecipesDetail) {
        DispatchQueue.main.async { [self] in
            let allRecipe = recipe.recipes[0]
            
            self.nameRecipeLabel.text = allRecipe.title
            self.summuryText.text = allRecipe.summary

            self.timeCookLabel.text = "\(allRecipe.readyInMinutes) minutes"
            
            self.collectionItems = ["Vegetarian": allRecipe.vegetarian,
                                    "Vegan": allRecipe.vegan,
                                    "Gluten Free": allRecipe.glutenFree,
                                    "Dairy Free": allRecipe.dairyFree,
                                    "Very Healthy": allRecipe.veryHealthy,
                                    "Cheap": allRecipe.cheap,
                                    "Very Popular": allRecipe.veryPopular,
                                    "Sustainable": allRecipe.sustainable]

            let urls = URL(string: allRecipe.image)
                    
                    if let data = try? Data(contentsOf: urls!)
                    {
                        let image: UIImage = UIImage(data: data)!
                        self.recipeImage.image = image
                    }
        }
    }
}

extension RandomRecipeViewController {
    
    private func setupScrollView(){
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
    }
    
    private func customRecipeImage(){
        recipeImage.translatesAutoresizingMaskIntoConstraints = false
        recipeImage.contentMode = .scaleAspectFit
        recipeImage.image = Asset.food.image
    }
    
    private func setupViewsRecioeImage() {
        contentView.addSubview(recipeImage)
        recipeImage.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        recipeImage.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        recipeImage.widthAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true
        recipeImage.heightAnchor.constraint(equalToConstant: 250).isActive = true
    }
    
    private func customNameRecipeLabel() {
        nameRecipeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        nameRecipeLabel.textAlignment = NSTextAlignment.center
        nameRecipeLabel.textColor = Asset.textColor.color
        nameRecipeLabel.font = UIFont.systemFont(ofSize: 20.0, weight: .bold)
        nameRecipeLabel.numberOfLines = 0
        
        nameRecipeLabel.text = "Cake"
        
        nameRecipeLabel.clipsToBounds = true
    }
    
    private func setupViewsNameRecipeLabel() {
        contentView.addSubview(nameRecipeLabel)
        nameRecipeLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        nameRecipeLabel.topAnchor.constraint(equalTo: recipeImage.bottomAnchor, constant: 15).isActive = true
        
        nameRecipeLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 15).isActive = true
        nameRecipeLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -15).isActive = true
    }
    
    private func setupViewsCollection() {
        contentView.addSubview(collectionView)
        collectionView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        collectionView.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        collectionView.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: nameRecipeLabel.bottomAnchor, constant: 20).isActive = true
        collectionView.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    private func customCollection() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
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
    
    private func setupViewsBackButtons(){
        contentView.addSubview(viewBackButton)
        viewBackButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        viewBackButton.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 10).isActive = true
        viewBackButton.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 15).isActive = true
        viewBackButton.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -15).isActive = true
        viewBackButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    private func customViewButton() {
        viewBackButton.translatesAutoresizingMaskIntoConstraints = false
        
        viewBackButton.addSubview(favouriteButton)
        viewBackButton.addSubview(moreButton)
        viewBackButton.addSubview(timeCookLabel)
        
        favouriteButton.centerXAnchor.constraint(equalTo: viewBackButton.centerXAnchor).isActive = true
        favouriteButton.centerYAnchor.constraint(equalTo: viewBackButton.centerYAnchor).isActive = true
        
        favouriteButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        favouriteButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        
        timeCookLabel.centerYAnchor.constraint(equalTo: viewBackButton.centerYAnchor).isActive = true
        timeCookLabel.leftAnchor.constraint(equalTo: viewBackButton.leftAnchor, constant: 10).isActive = true
        timeCookLabel.rightAnchor.constraint(equalTo: favouriteButton.leftAnchor, constant: -10).isActive = true
        
        moreButton.centerYAnchor.constraint(equalTo: viewBackButton.centerYAnchor).isActive = true
        moreButton.rightAnchor.constraint(equalTo: viewBackButton.rightAnchor, constant: -10).isActive = true
        moreButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        moreButton.widthAnchor.constraint(equalToConstant: 60).isActive = true
    }
    
    private func customTimeLabel() {
        timeCookLabel.translatesAutoresizingMaskIntoConstraints = false
        timeCookLabel.textAlignment = NSTextAlignment.left
        timeCookLabel.textColor = Asset.textColor.color
        timeCookLabel.font = UIFont.systemFont(ofSize: 12.0, weight: .regular)
        timeCookLabel.numberOfLines = 0
        timeCookLabel.clipsToBounds = true
    }
    
    private func customFavouriteButton() {
        favouriteButton.translatesAutoresizingMaskIntoConstraints = false
        // заменить на иконку фаворит
        let image = Asset.food.name
        favouriteButton.setImage(UIImage(named: image), for: .normal)
    }
    
    private func customMoreButton() {
        moreButton.translatesAutoresizingMaskIntoConstraints = false
        moreButton.setTitle("More", for: .normal)
        moreButton.setTitleColor(Asset.tabBarTintColor.color, for: .normal)
        moreButton.titleLabel?.font = UIFont.systemFont(ofSize: 12.0)
        moreButton.layer.cornerRadius = 8
        moreButton.layer.borderWidth = 1
        moreButton.layer.borderColor = Asset.tabBarTintColor.color.cgColor
        moreButton.clipsToBounds = true
    }
    
    private func setupViewsSummuryText(){
        contentView.addSubview(summuryText)
        summuryText.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        summuryText.topAnchor.constraint(equalTo: viewBackButton.bottomAnchor, constant: 10).isActive = true
        summuryText.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 15).isActive = true
        summuryText.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -15).isActive = true
        summuryText.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
    
    private func customSummuryLabel() {
        summuryText.translatesAutoresizingMaskIntoConstraints = false
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
        return collectionItems.keys.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
}

