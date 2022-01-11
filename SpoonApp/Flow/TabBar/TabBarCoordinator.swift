import UIKit
import Swinject

final class TabBarCoordinator: NavigationNode {

    private weak var tabBarController: UITabBarController?
    private var container: Container!
    
    override init(parent: NavigationNode?) {
        super.init(parent: parent)
        
        registerFlow()
        addHandlers()
    }
   
    private func registerFlow() {
        container = Container()
        
        TabBarAssembly(self).assemble(container: container)
    }
  
    private func addHandlers() {
        // add Settings flow event handlers
    }
    
}

extension TabBarCoordinator: Coordinator {
    
    func createFlow() -> UIViewController {
        let tabBarViewController = container.resolve(TabBarViewController.self)
        tabBarController = tabBarViewController
        
        let randomCoordinator = RecipeCoordinator(parent: self)
        let randomViewController = randomCoordinator.createFlow()
        let recipeTitle = L10n.recipeTitleVC
        let recipeImage = UIImage(systemName: "book")
        let recipeSelectedImage = UIImage(systemName: "book.fill")
        
        let recipeTabBarItem = UITabBarItem(title: recipeTitle,
                                            image: recipeImage,
                                            selectedImage: recipeSelectedImage)
        randomViewController.tabBarItem = recipeTabBarItem
        
        
        let favouriteCoordinator = FavouriteCoordinator(parent: self)
        let favouriteViewController = favouriteCoordinator.createFlow()
        let favouriteTitle = L10n.favouritesTitleVC
        let favouriteImage = UIImage(systemName: "heart")
        let favouriteSelectedImage = UIImage(systemName: "heart.fill")
        
        let favouriteTabBarItem = UITabBarItem(title: favouriteTitle,
                                               image: favouriteImage,
                                               selectedImage: favouriteSelectedImage)
        
        favouriteViewController.tabBarItem = favouriteTabBarItem
        
        let menuCoordinator = MenuCoordinator(parent: self)
        let menuViewController = menuCoordinator.createFlow()
        let menuTitle = L10n.menuTitleVC
        let menuImage = UIImage(systemName: "menucard")
        let menuSelectedImage = UIImage(systemName: "menucard.fill")
        
        let menuTabBarItem = UITabBarItem(title: menuTitle,
                                          image: menuImage,
                                          selectedImage: menuSelectedImage)
        
        menuViewController.tabBarItem = menuTabBarItem
 
        tabBarController!.viewControllers = [randomViewController,
                                            favouriteViewController,
                                            menuViewController]
        
        return tabBarController!
    }
  
}
