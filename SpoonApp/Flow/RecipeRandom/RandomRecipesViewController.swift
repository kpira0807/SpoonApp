import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class RandomRecipesViewController: UIViewController {

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
        activityIndicatorContainer.layer.cornerRadius = 10.0
        
        return activityIndicatorContainer
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = .large
        
        return activityIndicator
    }()

    @objc private lazy var openDetailInfoButton: UIBarButtonItem = {
        let openDetailInfoButton = UIBarButtonItem.init(
            title: L10n.moreButton,
            style: .plain,
            target: self,
            action: #selector(openDetailScreen)
        )
        
        return openDetailInfoButton
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

        let addToFavouriteButton = UIBarButtonItem.init(
            image: UIImage(systemName: "heart"),
            style: .plain,
            target: self,
            action: #selector(addToFavouriteButton)
            )

        self.navigationItem.rightBarButtonItem  = addToFavouriteButton
        self.navigationItem.leftBarButtonItem  = openDetailInfoButton
        
        self.navigationController?.navigationBar.tintColor = Asset.tabBarTintColor.color
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: Asset.textColor.color]
        
        self.navigationItem.title = L10n.recipeTitleVC

        view.backgroundColor = .white
        layoutTableView()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        setupTableView()

        initializedBindings()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        initializedBindings()
    }
    
    
    @objc func addToFavouriteButton() {
    }
    
    @objc func openDetailScreen() {
    }
    
    private func initializedBindings() {
        viewModel.viewDidLoad()

        viewModel.reloadData.subscribe(onNext: { [weak self] _ in
            self?.tableView.reloadData()
        }).disposed(by: disposeBag)
      }
    
    private func setupTableView() {
        tableView.registerReusableCell(cellType: ImageNameTableViewCell.self)
        tableView.registerReusableCell(cellType: CategoriesTableViewCell.self)
        tableView.registerReusableCell(cellType: TimeButtonsTableViewCell.self)
        tableView.registerReusableCell(cellType: SummaryTableViewCell.self)
    }
    
}

extension RandomRecipesViewController {
 
    private func layoutTableView() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
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
        viewModel.cellViewModels.count
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
