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
    
    @objc private lazy var infoButton: UIBarButtonItem = {
        let infoButton = UIBarButtonItem(
            title: L10n.moreButton,
            style: .plain,
            target: self,
            action: #selector(infoButtonAction)
        )
        
        return infoButton
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
        
        let addToFavouriteButton = UIBarButtonItem(
            image: UIImage(systemName: "heart"),
            style: .plain,
            target: self,
            action: #selector(addToFavouriteButtonAction)
        )
        
        navigationItem.rightBarButtonItem = addToFavouriteButton
        navigationItem.leftBarButtonItem = infoButton
        
        navigationController?.navigationBar.tintColor = Asset.tabBarTintColor.color
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: Asset.textColor.color]
        
        navigationItem.title = L10n.recipeTitleVC
        
        view.backgroundColor = .white
        layoutTableView()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        setupTableView()
        setupActivityIndicator()
        
        initializedBindings()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        initializedBindings()
    }
    
    @objc func addToFavouriteButtonAction() {
    }
    
    @objc func infoButtonAction() {
    }
    
    private func initializedBindings() {
        activityIndicator.startAnimating()
        viewModel.loadRandomRecipes.onNext(())
        
        viewModel.reloadData.subscribe(onNext: { [weak self] _ in
            guard let strongSelf = self else { return }
            strongSelf.tableView.reloadData()
            strongSelf.activityIndicator.stopAnimating()
            strongSelf.activityIndicatorContainer.isHidden = true
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
            make.center.equalToSuperview()
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
