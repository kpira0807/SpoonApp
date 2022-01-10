import UIKit
import Swinject

class TabBarCoordinator: NavigationNode {

    private var container: Container!
    weak var containerViewController: UIViewController?
    
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
        
        let randomCoordinator = RecipeCoordinator(parent: self)
        let randomViewController = randomCoordinator.createFlow()
        randomCoordinator.containerViewController = randomViewController
        
        
        let favouriteCoordinator = FavouriteCoordinator(parent: self)
        let favouriteViewController = favouriteCoordinator.createFlow()
        favouriteCoordinator.containerViewController = favouriteViewController
        
        
        let menuCoordinator = MenuCoordinator(parent: self)
        let menuViewController = menuCoordinator.createFlow()
        menuCoordinator.containerViewController = menuViewController
        
        
        let tabBarController = TabBarViewController()
        tabBarController.viewControllers = [randomViewController,
                                            favouriteViewController,
                                            menuViewController]

        return tabBarController
    }
}
