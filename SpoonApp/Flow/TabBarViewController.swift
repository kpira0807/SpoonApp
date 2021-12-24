import UIKit

class TabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        self.tabBar.tintColor = Asset.tabBarTintColor.color
        self.tabBar.unselectedItemTintColor = Asset.tabBarTintColor.color
        
        setupTabBar()
        self.customTabBar()
    }
}

extension TabBarViewController {
    
    func setupTabBar() {
        let randomRecipeVC = RandomRecipeViewController(RecipeViewModel(model: RecipeModel()))!
        randomRecipeVC.tabBarItem = UITabBarItem(title: L10n.recipeTitleVC, image: UIImage(systemName: "book"), selectedImage: UIImage(systemName: "book.fill"))
        
        let favouriteRecipeVC = FavoriteRecipeTableViewController()
        favouriteRecipeVC.tabBarItem = UITabBarItem(title: L10n.favouritesTitleVC, image: UIImage(systemName: "heart"), selectedImage: UIImage(systemName: "heart.fill"))
        
        let menuRecipeVC = MenuViewController()
        menuRecipeVC.tabBarItem = UITabBarItem(title: L10n.menuTitleVC, image: UIImage(systemName: "menucard"), selectedImage: UIImage(systemName: "menucard.fill"))
        
        viewControllers = [randomRecipeVC, favouriteRecipeVC, menuRecipeVC]
    }
    
    func customTabBar() {
        self.tabBar.layer.masksToBounds = true
        self.tabBar.isTranslucent = true
        self.tabBar.layer.cornerRadius = 20
        self.tabBar.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
}
