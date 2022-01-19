import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class RandomRecipesViewController: UIViewController {
    
    private var isAnswerReady = false
    var recipeAll: RecipesDetail
    private let disposeBag = DisposeBag()
    private let viewModel: RecipeViewModel
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorColor = UIColor.clear
        
        return tableView
    }()
    
    private lazy var activityIndicatorContainer: UIView = {
        let activityIndicatorContainer = UIView()
        activityIndicatorContainer.backgroundColor = .black
        activityIndicatorContainer.alpha = 0.8
        activityIndicatorContainer.layer.cornerRadius = 10
        
        return activityIndicatorContainer
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = .large
        
        return activityIndicator
    }()
    
    init(_ viewModel: RecipeViewModel) {
        self.viewModel = viewModel
        self.recipeAll = RecipesDetail(recipes: [Recipes]())
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        
        setupActivityIndicator()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setupTableView(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.usersUpdate()
            .subscribe { [weak self] (answer) in
                guard let self = self else { return }
                if answer != nil {
                    self.isAnswerReady = true
                }
                self.recipeAll = answer!
                print("Recipe All - \(self.recipeAll)")
            } onError: { (error) in
                print(error)
            } .disposed(by: self.disposeBag)
    }
    
    private func setupTableView() {
      tableView.registerReusableCell(cellType: ImageNameTableViewCell.self)
      tableView.registerReusableCell(cellType: CategoriesTableViewCell.self)
      tableView.registerReusableCell(cellType: TimeButtonsTableViewCell.self)
      tableView.registerReusableCell(cellType: SummuryTableViewCell.self)
    }
    
}

extension RandomRecipesViewController {
 
    private func setupTableView(_ table: UITableView) {
        view.addSubview(table)
        table.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setupActivityIndicator() {
        view.addSubview(activityIndicatorContainer)
        activityIndicatorContainer.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.width.equalTo(80.0)
        }
          
        activityIndicatorContainer.addSubview(activityIndicator)
        activityIndicator.snp.makeConstraints { make in
            make.center.equalTo(activityIndicatorContainer)
        }
    }
    
}

extension RandomRecipesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellViewModel = viewModel.cellViewModels[indexPath.row]
        let cell = tableView.dequeueReusableCell(withModel: cellViewModel, for: indexPath)
        
        return cell
    }
  
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let cellViewModel = viewModel.cellViewModels[indexPath.row]

        return cellViewModel.height
    }
   
    
}

