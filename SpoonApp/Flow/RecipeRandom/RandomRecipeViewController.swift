import UIKit
import SnapKit
import RxSwift
import RxCocoa

struct Utilites {
    var name: String
    var status: Bool
}

final class RandomRecipeViewController: UIViewController {
    
    var utilites = [Utilites]()
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
                Utilites(
                    name: L10n.vegetarian,
                    status: allRecipe.vegetarian ?? false
                ),
                Utilites(
                    name: L10n.vegan,
                    status: allRecipe.vegan ?? false
                ),
                Utilites(
                    name: L10n.glutenFree,
                    status: allRecipe.glutenFree ?? false
                ),
                Utilites(
                    name: L10n.dairyFree,
                    status: allRecipe.dairyFree ?? false
                ),
                Utilites(
                    name: L10n.veryHealthy,
                    status: allRecipe.veryHealthy ?? false
                ),
                Utilites(
                    name: L10n.cheap,
                    status: allRecipe.cheap ?? false
                ),
                Utilites(
                    name: L10n.veryPopular,
                    status: allRecipe.veryPopular ?? false
                ),
                Utilites(
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
            make.centerX.equalTo(view.center.x)
            make.width.equalTo(view.snp.width)
            make.top.equalTo(view.snp.top)
            make.bottom.equalTo(view.snp.bottom)
        }
        
        contentScrollView.snp.makeConstraints{ make in
            make.centerX.equalTo(scrollView.snp.centerX)
            make.width.equalTo(scrollView.snp.width)
            make.top.equalTo(scrollView.snp.top)
            make.bottom.equalTo(scrollView.snp.bottom)
        }
    }
    
    private func positionViews() {
        contentScrollView.addSubview(viewBackgroundImageName)
        contentScrollView.addSubview(viewBackgroundUtilites)
        contentScrollView.addSubview(viewBackgroundCollection)
        contentScrollView.addSubview(viewBackgroundSummury)

        viewBackgroundImageName.snp.makeConstraints{ make in
            make.top.equalTo(contentScrollView.snp.top)
            make.left.equalTo(contentScrollView.snp.left)
            make.right.equalTo(contentScrollView.snp.right)
            make.height.equalTo(380)
        }

        viewBackgroundCollection.snp.makeConstraints{ make in
            make.top.equalTo(viewBackgroundImageName.snp.bottom).offset(15)
            make.left.equalTo(contentScrollView.snp.left)
            make.right.equalTo(contentScrollView.snp.right)
            make.height.equalTo(35)
        }

        viewBackgroundUtilites.snp.makeConstraints{ make in
            make.top.equalTo(viewBackgroundCollection.snp.bottom).offset(10)
            make.right.equalTo(contentScrollView.snp.right)
            make.left.equalTo(contentScrollView.snp.left)
            make.height.equalTo(50)
        }

        viewBackgroundSummury.snp.makeConstraints{ make in
            make.top.equalTo(viewBackgroundUtilites.snp.bottom).offset(10)
            make.left.equalTo(contentScrollView.snp.left)
            make.right.equalTo(contentScrollView.snp.right)
            make.bottom.equalTo(contentScrollView.snp.bottom)
        }
    }
    
    private func sizeImageName() {
        viewBackgroundImageName.addSubview(recipeImage)

        recipeImage.snp.makeConstraints{ make in
            make.centerX.equalTo(viewBackgroundImageName.snp.centerX)
            make.top.equalTo(viewBackgroundImageName.snp.top)
            make.width.equalTo(viewBackgroundImageName.snp.width)
            make.height.equalTo(300)
        }
        
        viewBackgroundImageName.addSubview(nameRecipeLabel)

        nameRecipeLabel.snp.makeConstraints{ make in
            make.centerX.equalTo(viewBackgroundImageName.snp.centerX)
            make.top.equalTo(recipeImage.snp.bottom).offset(15)
            make.left.equalTo(viewBackgroundImageName.snp.left).offset(15)
            make.right.equalTo(viewBackgroundImageName.snp.right).offset(-15)
        }
    }
    
    private func sizeViewsCollection() {
        viewBackgroundCollection.addSubview(collectionView)

        collectionView.snp.makeConstraints{ make in
            make.left.equalTo(viewBackgroundCollection.snp.left)
            make.right.equalTo(viewBackgroundCollection.snp.right)
            make.width.equalTo(viewBackgroundCollection.snp.width)
            make.height.equalTo(30)
        }
        
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
    
    private func sizeViewBackgroundUtilites() {
        
        viewBackgroundUtilites.addSubview(favouriteButton)
        viewBackgroundUtilites.addSubview(moreButton)
        viewBackgroundUtilites.addSubview(timeCookLabel)

        favouriteButton.snp.makeConstraints{ make in
            make.centerX.equalTo(viewBackgroundUtilites.snp.centerX)
            make.centerY.equalTo(viewBackgroundUtilites.snp.centerY)
            make.height.equalTo(30)
            make.width.equalTo(30)
        }

        timeCookLabel.snp.makeConstraints{ make in
            make.centerY.equalTo(viewBackgroundUtilites.snp.centerY)
            make.left.equalTo(viewBackgroundUtilites.snp.left).offset(20)
            make.right.equalTo(favouriteButton.snp.left).offset(-10)
        }

        moreButton.snp.makeConstraints{ make in
            make.centerY.equalTo(viewBackgroundUtilites.snp.centerY)
            make.right.equalTo(viewBackgroundUtilites.snp.right).offset(-20)
            make.height.equalTo(40)
            make.width.equalTo(60)
        }
    }

    private func sizeSummuryText(){
        viewBackgroundSummury.addSubview(summuryText)

        summuryText.snp.makeConstraints{ make in
            make.centerX.equalTo(viewBackgroundSummury.snp.centerX)
            make.top.equalTo(viewBackgroundSummury.snp.top).offset(5)
            make.left.equalTo(viewBackgroundSummury.snp.left).offset(15)
            make.right.equalTo(viewBackgroundSummury.snp.right).offset(-15)
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
