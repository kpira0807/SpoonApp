import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class RandomRecipeViewController: UIViewController {
    
    var utilites = [CategoryRecipe]()
    private let disposeBag = DisposeBag()
    private let viewModel: RecipeViewModel
    
    // scroll for all screen
    private lazy var scrollView = UIScrollView()
    
    // view for scroll
    private lazy var contentScrollView = UIView()
    
    // view for image and name recipe
    private lazy var viewBackgroundImageName = UIView()
    
    // view for collection with information about recipe
    private lazy var viewBackgroundCollection = UIView()
    
    // view for favourite button, detail button and cook time
    private lazy var viewBackgroundUtilites = UIView()
    
    // view for summury
    private lazy var viewBackgroundSummury = UIView()
    
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
    
    private let collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout.init())
        collectionView.register(CategoriesCollectionViewCell.self, forCellWithReuseIdentifier: CategoriesCollectionViewCell.identifier)
        
        return collectionView
    }()
    
    private lazy var summuryText: UILabel = {
        let summuryText = UILabel()
        summuryText.numberOfLines = 0
        summuryText.clipsToBounds = true
        
        return summuryText
    }()
    
    init(_ viewModel: RecipeViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        setupScrollView()
        positionViews()
        sizeImageName()
        sizeViewsCollection()
        sizeViewBackgroundUtilites()
        sizeSummuryText()
        
        setup()
        
        favouriteButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        
        moreButton.addTarget(self, action: #selector(handlePresentingVC(_:)), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.usersUpdate()
        
        ///For RxSwift
        /*
         .observeOn(MainScheduler.asyncInstance)
         .subscribe { [weak self] (answer) in
         guard let self = self else { return }
         self.setup()
         } onError: { (error) in
         print(error)
         } .disposed(by: self.disposeBag)
         */
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setup()
    }
    
    private func setup() {
        viewModel.updateRecipeData = { [weak self] recipe in
            self?.updateRecipe(recipe)
        }
    }
    
    // action for favourite button
    @objc func buttonAction() {
        favouriteButton.setImage(UIImage(named:Asset.heartfill.name), for: .normal)
    }
    
    // open detail screen with all information about recipe
    @objc func handlePresentingVC(_ sender: UIButton) {
        let vc = viewModel.buttonAction()
        present(vc, animated: true, completion: nil)
    }
    
    private func updateRecipe(_ recipe: RecipesDetail) {
        DispatchQueue.main.async { [weak self] in
            let allRecipe = recipe.recipes[0]
            
            self?.nameRecipeLabel.text = allRecipe.title
            self?.summuryText.attributedText = allRecipe.summary?.convertHtmlToAttributedStringWithCSS(font: UIFont.systemFont(ofSize: 14.0), csscolor: "black", lineheight: 5, csstextalign: "justify")
            
            self?.timeCookLabel.text = "\(allRecipe.readyInMinutes ?? 0) minutes"
            
            self?.utilites = [
                CategoryRecipe(
                    name: L10n.vegetarian,
                    status: allRecipe.vegetarian ?? false
                ),
                CategoryRecipe(
                    name: L10n.vegan,
                    status: allRecipe.vegan ?? false
                ),
                CategoryRecipe(
                    name: L10n.glutenFree,
                    status: allRecipe.glutenFree ?? false
                ),
                CategoryRecipe(
                    name: L10n.dairyFree,
                    status: allRecipe.dairyFree ?? false
                ),
                CategoryRecipe(
                    name: L10n.veryHealthy,
                    status: allRecipe.veryHealthy ?? false
                ),
                CategoryRecipe(
                    name: L10n.cheap,
                    status: allRecipe.cheap ?? false
                ),
                CategoryRecipe(
                    name: L10n.veryPopular,
                    status: allRecipe.veryPopular ?? false
                ),
                CategoryRecipe(
                    name: L10n.sustainable,
                    status: allRecipe.sustainable ?? false
                )
            ]
            
            self?.collectionView.reloadData()
            
            let urls = URL(string: allRecipe.image ?? Asset.food.name)
            
            if let data = try? Data(contentsOf: urls!)
            {
                let image: UIImage = UIImage(data: data)!
                self?.recipeImage.image = image
            }
        }
    }
    
}

extension RandomRecipeViewController {
    
    /// Position for all elements
    private func setupScrollView(){
        view.addSubview(scrollView)
        scrollView.addSubview(contentScrollView)
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        contentScrollView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview().priority(250)
            make.width.equalToSuperview()
        }
    }
    
    private func positionViews() {
        contentScrollView.addSubview(viewBackgroundImageName)
        contentScrollView.addSubview(viewBackgroundUtilites)
        contentScrollView.addSubview(viewBackgroundCollection)
        contentScrollView.addSubview(viewBackgroundSummury)
        
        viewBackgroundImageName.snp.makeConstraints{ make in
            make.top.equalTo(contentScrollView)
            make.left.equalTo(contentScrollView)
            make.right.equalTo(contentScrollView)
            make.height.equalTo(380.0)
        }
        
        viewBackgroundCollection.snp.makeConstraints{ make in
            make.top.equalTo(viewBackgroundImageName.snp.bottom).offset(15)
            make.left.equalTo(contentScrollView)
            make.right.equalTo(contentScrollView)
            make.height.equalTo(30.0)
        }
        
        viewBackgroundUtilites.snp.makeConstraints{ make in
            make.top.equalTo(viewBackgroundCollection.snp.bottom).offset(10)
            make.left.equalTo(contentScrollView)
            make.right.equalTo(contentScrollView)
            make.height.equalTo(50.0)
        }
        
        viewBackgroundSummury.snp.makeConstraints{ make in
            make.top.equalTo(viewBackgroundUtilites.snp.bottom).offset(10)
            make.left.equalTo(contentScrollView)
            make.right.equalTo(contentScrollView)
            make.bottom.equalTo(contentScrollView)
        }
    }
    
    private func sizeImageName() {
        viewBackgroundImageName.addSubview(recipeImage)
        
        recipeImage.snp.makeConstraints{ make in
            make.centerX.equalTo(viewBackgroundImageName)
            make.top.equalTo(viewBackgroundImageName)
            make.width.equalTo(viewBackgroundImageName)
            make.height.equalTo(300.0)
        }
        
        viewBackgroundImageName.addSubview(nameRecipeLabel)
        
        nameRecipeLabel.snp.makeConstraints{ make in
            make.centerX.equalTo(viewBackgroundImageName)
            make.top.equalTo(recipeImage.snp.bottom).offset(15)
            make.left.equalTo(viewBackgroundImageName).offset(15)
            make.right.equalTo(viewBackgroundImageName).offset(-15)
        }
    }
    
    private func sizeViewsCollection() {
        viewBackgroundCollection.addSubview(collectionView)
        
        collectionView.snp.makeConstraints{ make in
            make.edges.equalTo(viewBackgroundCollection)
        }
        
        let cellSize = CGSize(width: view.bounds.width/3, height:28.0)
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
        layout.scrollDirection = .horizontal
        layout.itemSize = cellSize
        layout.sectionInset = UIEdgeInsets(top: 1, left: 1, bottom: 1, right: 1)
        layout.minimumLineSpacing = 1.0
        layout.minimumInteritemSpacing = 1.0
        collectionView.setCollectionViewLayout(layout, animated: true)
        collectionView.reloadData()
    }
    
    private func sizeViewBackgroundUtilites() {
        
        viewBackgroundUtilites.addSubview(favouriteButton)
        viewBackgroundUtilites.addSubview(moreButton)
        viewBackgroundUtilites.addSubview(timeCookLabel)
        
        favouriteButton.snp.makeConstraints{ make in
            make.center.equalTo(viewBackgroundUtilites)
            make.width.height.equalTo(30.0)
        }
        
        timeCookLabel.snp.makeConstraints{ make in
            make.centerY.equalTo(viewBackgroundUtilites)
            make.left.equalTo(viewBackgroundUtilites).offset(20)
            make.right.equalTo(favouriteButton).offset(-10)
        }
        
        moreButton.snp.makeConstraints{ make in
            make.centerY.equalTo(viewBackgroundUtilites)
            make.right.equalTo(viewBackgroundUtilites).offset(-20)
            make.height.equalTo(40.0)
            make.width.equalTo(60.0)
        }
    }
    
    private func sizeSummuryText(){
        viewBackgroundSummury.addSubview(summuryText)
        
        summuryText.snp.makeConstraints{ make in
            make.centerX.equalTo(viewBackgroundSummury)
            make.top.equalTo(viewBackgroundSummury).offset(5)
            make.left.equalTo(viewBackgroundSummury).offset(15)
            make.right.equalTo(viewBackgroundSummury).offset(-15)
            make.bottom.equalTo(viewBackgroundSummury)
        }
    }
    
}

extension RandomRecipeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoriesCollectionViewCell.identifier, for: indexPath) as? CategoriesCollectionViewCell else {
            
            return UICollectionViewCell()
        }
        
        if utilites[indexPath.row].status == false {
            cell.configure(categoties: utilites[indexPath.row].name, backColor: Asset.greyLight.color)
        } else {
            cell.configure(categoties: utilites[indexPath.row].name, backColor: Asset.backGreen.color)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return utilites.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
    }
    
}
