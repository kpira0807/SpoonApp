import UIKit

class RecipeRandomViewController: UIViewController {

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
/*
    private let viewModel: RecipeViewModel
    
    init?(_ viewModel: RecipeViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
  */
    
    private let viewModel: RandomRecipeViewModel
    var recipeAllInfo = [Recipes]()
    
    init?(_ viewModel: RandomRecipeViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        setupTableView()
        
        viewModel.parse {
            data in
            self.recipeAllInfo = data
            print("recipeAllInfo = \(self.recipeAllInfo[0].title)")
         //   print(self.recipeAllInfo)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
    //    setup()
        
      //  print("INIT")
     //   tableView.reloadData()
    }

/*
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        viewModel.userDidShake()
        setup()
    }

    private func setup() {
        viewModel.updateRecipeData = { [weak self] recipe in
            self?.updateRecipe(recipe)
        }
        self.tableView.reloadData()
    }

    private func updateRecipe(_ recipe: RecipesDetail) {
        DispatchQueue.main.async { [weak self] in
            let allRecipe = recipe.recipes
            self?.recipeAllInfo = allRecipe
            print("TITLE \(self?.recipeAllInfo[0].title ?? "")")
        }
    }
 */
 
 
}

extension RecipeRandomViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {

        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return 4
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: HeaderTableViewCell.identifier, for: indexPath) as? HeaderTableViewCell else {
                
                return UITableViewCell()
            }
        /*
            let urls = URL(string: recipeAllInfo[0].image)
            
            if let data = try? Data(contentsOf: urls!)
            {
                let image: UIImage = UIImage(data: data)!
                cell.configure(image: image, name: recipeAllInfo[0].title)
            }
        */
            return cell
        } else if indexPath.row == 1{
            guard let cell = tableView.dequeueReusableCell(withIdentifier: UtilitesTableViewCell.identifier, for: indexPath) as? UtilitesTableViewCell else {
                
                return UITableViewCell()
            }
            
         //   cell.configure(time: recipeAllInfo)
            
            return cell
        } else if indexPath.row == 2{
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CollectionTableViewCell.identifier, for: indexPath) as? CollectionTableViewCell else {
                
                return UITableViewCell()
            }
            
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SummuryTableViewCell.identifier, for: indexPath) as? SummuryTableViewCell else {
                
                return UITableViewCell()
            }

            
      //      cell.configure(summury: recipeAllInfo[0].summary)
            return cell
        }
    }


    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            
            return 400
        } else if indexPath.row == 1 || indexPath.row == 2 {
            
            return 50
        } else {
            
            return UITableView.automaticDimension
        }
    }
 
}

extension RecipeRandomViewController {
    
    func setupTableView() {
        tableView.register(HeaderTableViewCell.self, forCellReuseIdentifier: HeaderTableViewCell.identifier)
        tableView.register(UtilitesTableViewCell.self, forCellReuseIdentifier: UtilitesTableViewCell.identifier)
        tableView.register(CollectionTableViewCell.self, forCellReuseIdentifier: CollectionTableViewCell.identifier)
        tableView.register(SummuryTableViewCell.self, forCellReuseIdentifier: SummuryTableViewCell.identifier)
        
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            tableView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            tableView.leftAnchor.constraint(equalTo: self.view.leftAnchor)
        ])
    }
}
