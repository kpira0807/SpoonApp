import UIKit
import SnapKit
import RxSwift
import RxCocoa

class RandomRecipesViewController: UIViewController {
    
    var categoryRecipe = [CategoryRecipe]()
    private let disposeBag = DisposeBag()
    private let viewModel: RecipeViewModel
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(ImageNameTableViewCell.self, forCellReuseIdentifier: ImageNameTableViewCell.identifier)
        tableView.register(CategoriesTableViewCell.self, forCellReuseIdentifier: CategoriesTableViewCell.identifier)
        tableView.register(TimeButtonsTableViewCell.self, forCellReuseIdentifier: TimeButtonsTableViewCell.identifier)
        tableView.register(SummuryTableViewCell.self, forCellReuseIdentifier: SummuryTableViewCell.identifier)
        tableView.separatorColor = UIColor.clear
        
        return tableView
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
        view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        tableView.frame = view.bounds
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.usersUpdate()
    }
    
}

extension RandomRecipesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: ImageNameTableViewCell.identifier,
                for: indexPath
            ) as? ImageNameTableViewCell else {
                return UITableViewCell()}
            
            return cell
        } else if indexPath.row == 1 {
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: CategoriesTableViewCell.identifier,
                for: indexPath
            ) as? CategoriesTableViewCell else {
                return UITableViewCell()}
            
            
            return cell
        } else if indexPath.row == 2 {
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: TimeButtonsTableViewCell.identifier,
                for: indexPath
            ) as? TimeButtonsTableViewCell else {
                return UITableViewCell()}
            
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: SummuryTableViewCell.identifier,
                for: indexPath
            ) as? SummuryTableViewCell else {
                return UITableViewCell()}
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 380
        } else if indexPath.row == 1 {
            return 35
        } else if indexPath.row == 2 {
            return 50
        } else {
            return 400
        }
    }
    
}

